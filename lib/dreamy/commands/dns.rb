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
    
  end
end