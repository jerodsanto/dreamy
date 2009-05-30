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
      users = @account.mysql_users
      if users.empty?
        display "No MySQL users on this account"
      else
        user_table = table do |t|
          t.headings = 'Username', 'Database', 'Sel', 'Ins', 'Upd', 'Del', 'Cre', 'Drop', 'Ind', 'Alt'
          users.each { |u| t << [u.username,u.db,u.select,u.insert,u.update,u.delete,u.create,u.drop,u.index,u.alter]  }
        end
        display user_table
      end
    end
    
  end
end