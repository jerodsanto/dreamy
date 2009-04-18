module Dreamy::Command
  class Announce < Base

    def list
      if args.length > 0
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
        display "Must specify announcement list. eg - 'my_list@example.com'"
      end
    end

    private

    def extract_values(arg)
      arg =~ /^(.*)@(.*)$/
      return $1, $2
    end

  end
end