require 'rake'
require 'rake/testtask'

task :default => [:test_units]

desc "Run basic tests"
Rake::TestTask.new("test_units") { |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  t.warning = true
}

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "dreamy"
    gemspec.summary = "A Ruby library and command line tool for accessing DreamHost's API"
    gemspec.email = "jerod.santo@gmail.com"
    gemspec.homepage = "http://github.com/onesunone/dreamy"
    gemspec.authors = ["Jerod Santo", "Harlan Wood"]
    gemspec.files.exclude 'test/credentials.yml'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: bundle install"
end
