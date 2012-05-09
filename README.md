What is it?
===========

[Dreamy][1] is Ruby library and command line tool for interfacing with [DreamHost's API][2]. The API itself is still very young so this is by no means a comprehensive library. Please fork and contribute!


Install
=======

Grab the **canonical** gem from Gemcutter:

    gem sources -a http://gemcutter.org
    gem install dreamy

Or grab the **development** gem from GitHub:

    gem sources -a http://gems.github.com
    gem install sant0sk1-dreamy

Library Usage
=============

DreamHost requires a username (email or webID) and API key (available from your DH Panel) to make API requests. When creating a Dreamy instance you'll need to provide this data. The Dreamy command line tool (dh) gathers the necessary info from a configuration file or environment variables, but you can do it however you'd like.

To get started with the library, just require the gem:

    require 'dreamy'
    
Create a new object using your username and API key.
    
    account = Dreamy::Base.new(username,api_key)
    
Fetch an array of Dreamy::Domain objects:

    account.domains
    
Now that you have an array you can have your way with the data:

    account.domains.each do |d|
      puts d.domain
      puts d.type
      puts d.home
    end
    
Same goes with Users, DNS records, announcement list subscribers, MySQL databases, MySQL hosts, and MySQL users
    
    # fetch an array of Dreamy::User objects
    account.users
    
    # fetch an array of Dreamy::Dns objects
    account.dns
    
    # fetch an array of Dreamy::AnnounceList objects
    account.announce_lists 
    
    # fetch an array of Dreamy::Subscribers to an announcement list
    account.announce_list(listname,domain)
    
    # fetch an array of Dreamy::MysqlUser objects
    account.mysql_users
    
You can interact with announcement lists by adding and removing subscribers
    
    # add a new subscriber to an announcement list
    account.announce_add(listname,domain,email)
    
    # remove a subscriber from an announcement list
    account.announce_remove(listname,domain,email)
    
You can interact with DNS by adding and removing records

    # add a new A record for a subdomain of an hosted domain
    account.dns_add(subdomain,"A","123.321.123.321")
    
    # remove the A record just created
    account.dns_remove(subdomain,"A","123.321.123.321")
    
You can interact with your Private Server in many different ways

    # change a private server setting
    account.ps_set(ps_name,setting,value)
    
    # set the memory size (MB)
    account.ps_size_set(ps_name,"200")
    
    # reboot the server
    account.ps_reboot!(ps_name)
    
Check the base class for all the different API calls.
    
More and more functions will be added as time allows. If there's something missing that you want in, please:

fork -> commit -> pull request
    
Command Line Usage
==================

The Dreamy gem will install an executable called "dh". In order to use it, you'll need to set your DreamHost account username and API key. You can acquire an API key from the DreamHost panel. "dh" will fetch your API credentials from 2 places, respectively:

1)  A file called .dreamyrc in your $HOME directory with username on line 1, api key on line 2

An example ~/.dreamyrc would look like:

    dh_user@gmail.com
    34TGGGKBRG3YD1EA
    
2) Environment variables DH\_USER and DH\_KEY. You can set these by typing this in your shell:

    export DH_USER=dh_user@gmail.com
    export DH_KEY=34TGGGKBRG3YD1EA
    
If you want to make those environment variables permanent, add those 2 lines to the bottom of your ~/.bashrc


Run this from the command line to print the usage:

    dh help
    
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

     api:cmds                           # list all API commands the current API key has access to
     api:cmd_args                       # list all API commands including argument and result fields

Listing of passwords is no longer supported by the Dreamhost API.
     
That's it for now. New commands should be springing up as Dreamy and the DreamHost API mature!

TODO
====

* add real rdocs

[1]:http://github.com/sant0sk1/dreamy
[2]:http://wiki.Dreamy.com/API