require "bundler/setup"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)
Rubocop::RakeTask.new(:lint)

desc "Run RuboCop lint checks and RSpec code examples"
task test: %i(lint spec)

task default: %i(test build)
