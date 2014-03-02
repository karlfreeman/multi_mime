require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'yard'
YARD::Rake::YardocTask.new

require 'rspec/core/rake_task'
desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
desc 'Run rubocop'
Rubocop::RakeTask.new(:rubocop)

task default: :spec
task test: :spec
