module Dreamy::Command
  class Dns < Base
    
    def list
      dns = @account.dns
      
      if args.length > 0
        filter = args.shift.downcase
        dns = dns.select { |d| d.zone.match(filter) }
      end
      
      if dns.empty?
        display "No DNS records for this account or requested zone not found"
      else
        dns_table = table do |t|
          t.headings = 'Record', 'Type', 'Value'
          dns.each { |d| t << [d.record,d.type,d.value] if d.type != "TXT" }
        end
        display "NOTE: TXT records not displayed (too long)"
        display dns_table
      end
    end
    alias :index :list
    
    def add
      if args.length == 3
        record, type, value = args[0], args[1], args[2]
        @account.dns_add(record,type,value)
        display "Successfully added #{type} record of #{value} to #{record}"
        display "Please wait for DNS to propagate"
      else
        display "Usage: dh dns:add [new record] [type] [value]"
      end
    end
    
    def remove
      if args.length == 3
        record, type, value = args[0], args[1], args[2]
        @account.dns_remove(record,type,value)
        display "Successfully removed #{type} record of #{value} to #{record}"
        display "Please wait for DNS to propagate"
      else
        display "Usage: dh dns:remove [new record] [type] [value]"
      end
    end
    
  end
end