# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gizzmo}
  s.version = "0.14.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Maxwell"]
  s.date = %q{2012-02-27}
  s.description = %q{Gizzmo is a command-line client for managing gizzard clusters.}
  s.email = %q{kmaxwell@twitter.com}
  s.executables = ["setup_shards", "gizzmo"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/gizzmo",
    "bin/setup_shards",
    "gizzmo.gemspec",
    "lib/gizzard.rb",
    "lib/gizzard/commands.rb",
    "lib/gizzard/digest.rb",
    "lib/gizzard/migrator.rb",
    "lib/gizzard/nameserver.rb",
    "lib/gizzard/rebalancer.rb",
    "lib/gizzard/shard_template.rb",
    "lib/gizzard/thrift.rb",
    "lib/gizzard/transformation.rb",
    "lib/gizzard/transformation_op.rb",
    "lib/gizzard/transformation_scheduler.rb",
    "lib/gizzmo.rb",
    "lib/vendor/thrift_client/simple.rb",
    "test/config.yaml",
    "test/expected/blocked-transform-shard.txt",
    "test/expected/busy-transform-shard.txt",
    "test/expected/deep.txt",
    "test/expected/dry-wrap-table_b_0.txt",
    "test/expected/empty-file.txt",
    "test/expected/find-only-sql-shard-type.txt",
    "test/expected/forwardings.txt",
    "test/expected/help-info.txt",
    "test/expected/info.txt",
    "test/expected/links-for-replicating_table_b_0.txt",
    "test/expected/links-for-table_b_0.txt",
    "test/expected/links-for-table_repl_0.txt",
    "test/expected/original-find.txt",
    "test/expected/subtree-info.txt",
    "test/expected/subtree.txt",
    "test/expected/unwrapped-replicating_table_b_0.txt",
    "test/expected/unwrapped-table_b_0.txt",
    "test/expected/wrap-table_b_0.txt",
    "test/gizzmo_spec.rb",
    "test/helper.rb",
    "test/nameserver_spec.rb",
    "test/recreate.sql",
    "test/scheduler_spec.rb",
    "test/shard_template_spec.rb",
    "test/spec.opts",
    "test/spec_helper.rb",
    "test/test.sh",
    "test/test_server/.gitignore",
    "test/test_server/project/build.properties",
    "test/test_server/project/build/Project.scala",
    "test/test_server/project/plugins/Plugins.scala",
    "test/test_server/src/main/scala/Main.scala",
    "test/test_server/src/main/scala/TestServer.scala",
    "test/test_server/src/main/thrift/TestServer.thrift",
    "test/transformation_spec.rb"
  ]
  s.homepage = %q{http://github.com/twitter/gizzmo}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Gizzmo is a command-line client for managing gizzard clusters.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<mysql>, [">= 0"])
      s.add_runtime_dependency(%q<rspec>, ["~> 1.3.2"])
      s.add_runtime_dependency(%q<rr>, [">= 0"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 0"])
    else
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<mysql>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 1.3.2"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<diff-lcs>, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<mysql>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 1.3.2"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<diff-lcs>, [">= 0"])
  end
end

