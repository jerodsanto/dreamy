module Dreamy::Command
  class Announce < Base
    
    def index
      lists = @account.announce_lists
      
      if lists.empty?
        display "No announcement lists on this account"
      else
        list_table = table do |t|
          t.headings = 'Name', 'Short Name', 'Domain', 'Subscribers', 'Max Bounces', 'Start Date'
          lists.each { |l| t << [l.name, l.short_name, l.domain, l.subscribers, l.max_bounces, l.start_date]}
        end
        display list_table
      end
    end
    
    def list
      if args.length >= 1
        listname, domain = extract_values(args.shift)
        subscribers = @account.announce_list(listname,domain)
        if subscribers.empty?
          display "No subscribers to this list"
        else
          subscriber_table = table do |t|
            t.headings = 'email', 'name', 'subscribe_date', 'bounces'
            subscribers.each { |s| t << [s.email, s.name, s.subscribe_date, s.num_bounces] }
          end
          display subscriber_table
          display "#{subscribers.size} total subscribers"
        end
      else
        display "Usage: dh announce:list my_list@example.com"
      end
    end
    
    def add
      if args.length >= 2
        listname, domain = extract_values(args.shift)
        email = args.shift
        if @account.announce_add(listname,domain,email)
          display "Successfully added #{email} to #{listname} list"
        else
          display "Failed to add #{email} to #{listname} list"
        end
      else
        display "Usage: dh announce:add my_list@example.com new_guy@gmail.com"
      end
    end
    
    def remove
      if args.length >= 2
        listname, domain = extract_values(args.shift)
        email = args.shift
        if @account.announce_remove(listname,domain,email)
          display "Successfully removed #{email} from #{listname} list"
        else
          display "Failed to remove #{email} from #{listname} list"
        end
      else
        display "Usage: dh announce:remove my_list@example.com new_guy@gmail.com"
      end
    end

    private

    def extract_values(arg)
      arg =~ /^(.*)@(.*)$/
      return $1, $2
    end

  end
end