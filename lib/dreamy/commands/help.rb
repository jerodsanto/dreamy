module Dreamy::Command
	class Help < Base
		def index
			display usage
		end

		def usage
			usage = <<EOTXT

=== Commands
 
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
 
 mysql:dbs                          # list MySQL database details
 mysql:hosts                        # list MySQL database hostnames
 mysql:users                        # list MySQL user details
 
 ps                                 # list private servers
 ps:add <web|mysql> <yes|no>        # adds a private server of type <web|mysql>. Yes = move data
 ps:pending                         # list private servers scheduled to be created
 ps:reboots <name>                  # list historical reboots for <name>
 ps:reboot <name> now!              # reboot <name> now! (proceed with caution)
 ps:remove                          # removes all pending private servers
 ps:settings <name>                 # list settings for private server <name>
 ps:set <name> <setting> <value>    # change <setting> on <name> to <value>
 ps:size <name>                     # list historical memory sizes for <name>
 ps:size <name> <value>             # set new memory <value> for <name>
 ps:usage <name>                    # list historical memory & CPU usage for <name>
 
 users                              # list user accounts: details

EOTXT
		end
	end
end
