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
    
    def settings
      if args.length == 1
        settings = @account.ps_settings(args[0])
        settings_table = table do |t|
          t.headings = 'Setting', 'Value'
          settings.each { |k,v| t << [k,v] }
        end
        display settings_table
      else
        display "Usage: dh ps:settings [ps name]"
      end
    end
    
    def set
      if args.length == 3
        name, setting, value = args[0], args[1], args[2]
        @account.ps_set(name,setting,value)
        display "Successfully set #{setting} to #{value} for #{name}"
      else
        display "Usage: dh ps:set [ps name] [setting] [value]"
      end
    end
    
  end
end