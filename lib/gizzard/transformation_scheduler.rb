module Gizzard
  def self.schedule!(*args)
    Transformation::Scheduler.new(*args).apply!
  end

  class Transformation::Scheduler

    attr_reader :nameserver, :transformations
    attr_reader :max_copies, :copies_per_host

    DEFAULT_OPTIONS = {
      :max_copies => 30,
      :copies_per_host => 8,
      :poll_interval => 5
    }.freeze

    def initialize(nameserver, base_name, transformations, options = {})
      options = DEFAULT_OPTIONS.merge(options)
      @nameserver      = nameserver
      @transformations = transformations
      @max_copies      = options[:max_copies]
      @copies_per_host = options[:copies_per_host]
      @poll_interval   = options[:poll_interval]

      @jobs_in_progress = []
      @jobs_finished    = []

      @jobs_pending = transformations.map do |transformation, forwardings_to_shards|
        transformation.bind(base_name, forwardings_to_shards)
      end.flatten
    end

    # to schedule a job:
    # 1. pull a job that does not involve a disqualified host.
    # 2. run prepare ops
    # 3. reload app servers
    # 4. schedule copy
    # 5. put in jobs_in_progress

    # on job completion:
    # 1. run cleanup ops
    # 2. remove from jobs_in_progress
    # 3. put in jos_finished
    # 4. schedule a new job or reload app servers.

    def apply!
      loop do
        reload_busy_shards
        cleanup_jobs
        schedule_jobs(max_copies - busy_shards.length)

        break if @jobs_pending.empty? && @jobs_in_progress.empty?

        unless nameserver.dryrun?
          6.times do
            sleep(@poll_interval / 6.0)
            put_copy_progress
          end
        end
      end

      nameserver.reload_config

      log "All transformations applied. Have a nice day!"
    end

    def schedule_jobs(num_to_schedule)
      jobs = (1..num_to_schedule).map do
        job = @jobs_pending.find do |j|
          (busy_hosts & j.involved_hosts).empty?
        end

        @jobs_pending.delete(job)

        job
      end.compact

      unless jobs.empty?
        log "Jobs starting:"
        jobs.each {|j| log "  #{j.inspect(:prepare)}" }

        jobs.each {|j| j.prepare!(nameserver) }

        log "Reloading nameserver configuration."
        nameserver.reload_config

        copy_jobs = jobs.select {|j| j.copy_required? }

        unless copy_jobs.empty?
          log "Scheduling copies:"
          copy_jobs.each do |j|
            log "  #{j.inspect(:copy)}"
            j.copy!(nameserver)
          end
        end

        @jobs_in_progress.concat(jobs)
      end
    end

    def cleanup_jobs
      jobs = jobs_completed
      @jobs_in_progress -= jobs

      unless jobs.empty?
        log "Jobs finishing:"
        jobs.each {|j| log "  #{j.inspect(:cleanup)}" }
      end

      jobs.each {|j| j.cleanup!(nameserver) }

      @jobs_finished.concat(jobs)
    end

    def jobs_completed
      @jobs_in_progress.select {|j| (busy_shards & j.involved_shards).empty? }
    end

    def reload_busy_shards
      @busy_shards = nil
    end

    def busy_shards
      @busy_shards ||=
        if nameserver.dryrun?
          []
        else
          nameserver.get_busy_shards.map {|s| s.id }
        end
    end

    def busy_hosts
      copies_count_map = busy_shards.inject({}) do |h, shard|
        h.update(shard.hostname => 1) {|_,a,b| a + b }
      end

      copies_count_map.select {|_, count| count >= @max_copies }.map {|(shard, _)| shard }
    end

    def reset_progress_string
      if @progress_string
        @progress_string = nil
        puts ""
      end
    end

    def log(*args)
      reset_progress_string
      puts *args
    end

    def put_copy_progress
      @i ||= 0
      @i  += 1
      spinner = %w(- \ | /)[@i % 4]

      unless @jobs_in_progress.empty? || @busy_shards.empty?
        print "" * @progress_string.length if @progress_string
        @progress_string = "#{spinner} Copies in progress: #{@busy_shards.length}"
        print @progress_string
      end
    end
  end
end