require 'uri'
require 'net/https'
require 'yaml'
require 'rubygems'
require 'hpricot'
require 'uuid'


$:.unshift(File.dirname(__FILE__) + "/dreamhost")
require 'dreamhost/easy_class_maker'
require 'dreamhost/control'
require 'dreamhost/domain'
require 'dreamhost/dns'
require 'dreamhost/user'

module DreamHost
    class CantConnect < StandardError; end
    class Unavailable < StandardError; end
end