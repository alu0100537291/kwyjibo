require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

desc "Unit test"
task :test do
	sh "ruby -Ilib test/tc_kwyjibo.rb"
end