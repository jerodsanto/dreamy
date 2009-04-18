module DreamHost::Command
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
 
 users                        # list user accounts

EOTXT
		end
	end
end
