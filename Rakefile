require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "rubycritic/rake_task"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

RubyCritic::RakeTask.new do |task|
  files = FileList["**/*.rb"]
  files.exclude("**/*_spec.rb")
  files.exclude("**/*_shared_example.rb")

  task.paths = files
end

task :default => [:rubocop, :spec]
