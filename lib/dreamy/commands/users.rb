module Dreamy::Command
  class Users < Base
    
    # Command: 
    #    dh users
    #
    # Print table of users
    def index
      users = @account.users
      if users.empty?
        display "No users on this account"
      else
        user_table = table do |t|
          t.headings = 'Name', 'Account Type', 'Server', 'Disk used (MB)', 'Quota (MB)'
          users.each { |u| t << [u.gecos, u.type, u.home, u.disk_used_mb, u.quota_mb]  }
        end
        display user_table
      end
    end
        
  end
end
