require 'test/unit'
require 'rubygems'
require 'shoulda'

dir = File.dirname(__FILE__)

$:.unshift(File.join(dir, '/../lib/'))
require dir + '/../lib/dreamhost'

CREDS = YAML::load(File.open("#{dir}/credentials.yml"))