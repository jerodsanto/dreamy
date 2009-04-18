module Dreamy::Command
	class Help < Base
		def index
			display usage
		end

		def usage
			usage = <<EOTXT

=== Commands

 help                         # show this usage

 domains                      # list domains
 domains:status               # check availability of all domains
 
 dns                          # list your DNS records
 dns <name>                   # list DNS records for <ame>
 
 announce:list <name>         # lists all subscribers to <name> list (eg - 'my_list@example.com')
 announce:add <name>          # add a subscriber to <name> list (COMING SOON)
 announce:remove <name>       # remove a subscriber from <name> list (COMING SOON)
 
 users                        # list user accounts

EOTXT
		end
	end
end
