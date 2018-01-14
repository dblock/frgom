require 'rubygems'
require 'bundler/gem_tasks'

Bundler.setup(:default, :development)

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: %i[spec rubocop]
