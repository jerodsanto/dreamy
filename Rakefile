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
    gemspec.homepage = "http://github.com/sant0sk1/dreamy"
    gemspec.authors = ["Jerod Santo"]
    gemspec.add_dependency('visionmedia-terminal-table', '>= 1.0.5')
    gemspec.add_dependency('hpricot', '>= 0.7')
    gemspec.add_dependency('uuid', '>= 2.0.1')
    gemspec.files.exclude 'test/credentials.yml'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end