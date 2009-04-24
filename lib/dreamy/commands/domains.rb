require 'ping'

module Dreamy::Command
  class Domains < Base
    
    def index
      http
    end
    
    def http
      domains = @account.domains.reject { |d| d.type != 'http'}
      
      if domains.empty?
        display "No HTTP domains on this account"
      else
        domain_table = table do |t|
          t.headings = 'Domain Name', 'Server', 'Type', 'User', 'WWW or Not'
          domains.each { |d| t << [d.domain,d.short_home,d.hosting_type,d.user,d.www_or_not]}
        end
        display domain_table
      end
    end
    
    def mysql
      domains = @account.domains.reject { |d| d.type != 'mysqldns'}
      
      if domains.empty?
        display "No MySQL domains on this account"
      else
        domain_table = table do |t|
          t.headings = 'Domain Name', 'Server'
          domains.each { |d| t << [d.domain,d.short_home]}
        end
        display domain_table
      end
    end
    
    def status
      domains = @account.domains
      domains.each do |d|
        if host_available?(d.domain)
          display "#{d.domain} is up"
        else
          display "#{d.domain} is down!"
          if host_available?(d.home)
            display "  But its host server (#{d.home}) is up"
          else
            display "  And its host server (#{d.home}) is down"
          end
        end
      end
    end
    
    protected
    
    def host_available?(host)
      Ping.pingecho host
    end
    
  end
end