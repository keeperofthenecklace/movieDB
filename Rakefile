require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/unit/test*.rb']
  t.verbose = true
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new
