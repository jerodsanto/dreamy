require 'uri'
require 'net/https'
require 'yaml'
require 'rubygems'
require 'hpricot'
require 'uuid'


$:.unshift(File.dirname(__FILE__) + "/dreamy")
require 'dreamy/easy_class_maker'
require 'dreamy/control'
require 'dreamy/domain'
require 'dreamy/dns'
require 'dreamy/user'

module Dreamy
    class CantConnect < StandardError; end
    class Unavailable < StandardError; end
end