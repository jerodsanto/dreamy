module Dreamy::Command
  class Mysql < Base
    
    def dbs
      dbs = @account.mysql_dbs
      if dbs.empty?
        display "No MySQL databases on this account"
      else
        db_table = table do |t|
          t.headings = 'Name', 'Home', 'Description', 'Disk used (MB)'
          dbs.each { |db| t << [db.name,db.home,db.description,db.disk_usage_mb]  }
        end
        display db_table
      end
    end
    alias :index :dbs
    
    def hosts
      hosts = @account.mysql_hosts
      if hosts.empty?
        display "No MySQL hosts on this account"
      else
        host_table = table do |t|
          t.headings = 'Domain Name','Home'
          hosts.each { |host| t << [host.domain,host.home]  }
        end
        display host_table
      end
    end
    
    def users
      
    end
  end
end