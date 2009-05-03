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
    
    def size
      case args.length
        when 1
        sizes = @account.ps_size_history(args[0])
        sizes_table = table do |t|
          t.headings = 'Time', 'Memory (MB)', 'Duration (Seconds)', 'Cost (Period)', 'Cost (Monthly)'
          sizes.each { |s| t << [s["stamp"],s["memory_mb"],s["period_seconds"],s["period_cost"],s["monthy_cost"]] }
        end
        display sizes_table
      when 2
        name, new_size = args[0], args[1]
        @account.ps_size_set(name,new_size)
        display "Successfully set memory size to #{new_size} for #{name}"
      else
        display "Usage: dh ps:size [ps name] [new size (optional)]"
      end
    end
    
    def reboots
      if args.length == 1
        reboots = @account.ps_reboot_history(args[0])
        reboots_table = table do |t|
          t.headings = 'Count', 'Reboot Time'
          reboots.each_with_index { |r,i| t << [i + 1,r] }
        end
        display reboots_table
      else
        display "Usage: dh ps:reboots [ps name]"
      end
    end
    
    def reboot
      if args.length == 2
        if args[1] == "now!"
          @account.ps_reboot!(args[0])
          display "Successfully sent reboot command for #{args[0]}"
        else
          display "Are you sure?? If yes, finish the command with 'now!'"
        end
      else
        display "Usage: dh ps:reboot [ps name] now! (WARNING: this will reboot your server)"
      end
    end
    
    def usage
      if args.length == 1
        usages = @account.ps_usage(args[0])
        usage_table = table do |t|
          t.headings = 'Time', 'Memory (MB)', 'CPU Load'
          usages.each { |u| t << [u["stamp"], u["memory_mb"],u["load"]] }
        end
        display usage_table
      else
        display "Usage: dh ps:usage [ps name]"
      end
    end
    
    def add
      case args.length
      when 1
        if args[0] == "web"
          display "you must specify 'yes' or 'no' for whether or not to move data to new server"
        else
          @account.ps_add(args[0])
          display "Successfully requested new private mysql server"
        end
      when 2
        type, move = args[0], args[1]
        @account.ps_add(type,move)
        display "Successfully requested new private server"
      else
        display "Usage: dh ps:add <web|mysql> <yes|no>"
      end
    end
    
    def remove
      @account.ps_remove
      display "Successfully removed all pending private server requests"
    end
    
    def pending
      pendings = @account.ps_pending
      if pendings.empty?
        display "You have no pending server creations"
      else
        pending_table = table do |t|
          t.headings = 'Account', 'IP Address', 'Type', 'Time'
          pendings.each { |p| t << [p["account_id"],p["ip"],p["type"],p["stamp"]]}
        end
        display pending_table
      end
    end
    
  end
end