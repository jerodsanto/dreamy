module Dreamy::Command
	class Help < Base
		def index
			display usage
		end

		def usage
			usage = <<EOTXT

=== Commands
 help                           # show this usage

 domains                        # list domains
 domains:status                 # check availability of all domains
 
 dns                            # list your DNS records
 dns <name>                     # list DNS records for <ame>
 
 announce:list <list>           # lists all subscribers to <name> list (eg - 'my_list@example.com')
 announce:add <list> <email>    # add a subscriber with <email> to <list>
 announce:remove <list> <email> # remove subscriber with <email> from <list>
 
 users                          # list user accounts

EOTXT
		end
	end
end
