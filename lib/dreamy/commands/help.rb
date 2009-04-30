module Dreamy::Command
	class Help < Base
		def index
			display usage
		end

		def usage
			usage = <<EOTXT

=== Commands
 help                               # show this usage
 
 announce                           # list announce lists
 announce:list <list>               # list all subscribers to <name> list
 announce:add <list> <email>        # add subscriber with <email> to <list>
 announce:remove <list> <email>     # remove subscriber with <email> from <list>

 dns                                # list DNS records
 dns <name>                         # list DNS records for <name>
 dns:add <record> <type> <value>    # add DNS record 
 dns:remove <record> <type> <value> # remove DNS record

 domains:http                       # list HTTP domain details
 domains:mysql                      # list MySQL domains
 domains:status                     # check availability of all domains (pingability)
 
 ps                                 # list private servers
 
 users                              # list user accounts: details
 users:pw                           # list user accounts: usernames & passwords

EOTXT
		end
	end
end
