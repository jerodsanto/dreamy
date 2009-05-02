module Dreamy::Command
  class Ps < Base
    
    def list
      servers = @account.ps
      
      if servers.empty?
        display "No private servers for this account"
      else
        servers_table = table do |t|
          t.headings = 'Name', 'Type', 'Memory (MB)', 'Start Date'
          servers.each { |ps| t << [ps.name,ps.type,ps.memory,ps.start_date]  }
        end
        display servers_table
      end
    end
    alias :index :list
    
  end
end