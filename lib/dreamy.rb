require 'uri'
require 'net/https'
require 'yaml'
require 'rubygems'
require 'hpricot'
require 'uuid'


$:.unshift(File.dirname(__FILE__) + "/dreamy")
require 'dreamy/core_extensions'
require 'dreamy/easy_class_maker'
require 'dreamy/base'
require 'dreamy/domain'
require 'dreamy/registration'
require 'dreamy/dns'
require 'dreamy/announce_list'
require 'dreamy/private_server'
require 'dreamy/subscriber'
require 'dreamy/user'
require 'dreamy/mail_filter'
require 'dreamy/mysql/db'
require 'dreamy/mysql/host'
require 'dreamy/mysql/user'

module Dreamy
    class CantConnect < StandardError; end
    class Unavailable < StandardError; end
    class ApiError    < StandardError; end
end