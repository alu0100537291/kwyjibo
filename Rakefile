require "bundler/gem_tasks"
require 'rdoc/task'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

desc "Unit test"
task :test do
	sh "ruby -Ilib test/tc_kwyjibo.rb"
end

Rake::RDocTask.new do |r|
	r.main = "README.md"
	r.rdoc_files.include("README.md", "lib/**/*.rb")
end