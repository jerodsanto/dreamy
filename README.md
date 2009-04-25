What is it?
===========

[Dreamy][1] is Ruby library and command line tool for interfacing with [DreamHost's API][2]. The API itself is still very young so this is by no means a comprehensive library. Please fork and contribute!


Install
=======

Grab the gem from GitHub

    gem sources -a http://gems.github.com
    gem install sant0sk1-dreamy

Library Usage
=============

DreamHost requires a username (email or webID) and API key (available from your DH Panel) to make API requests. When creating a Dreamy instance you'll need to provide this data. The Dreamy command line tool (dh) gathers the necessary info from a configuration file or environment variables, but you can do it however you'd like.

To get started with the library, just require the gem:

    require 'rubygems'
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
    
Same goes with Users, DNS records and announcement list subscribers
    
    # fetch an array of Dreamy::User objects
    account.users
    
    # fetch an array of Dreamy::Dns objects
    account.dns
    
    # fetch an array of Dreamy::AnnounceList objects
    account.announce_lists 
    
    # fetch an array of Dreamy::Subscribers to an announcement list
    account.announce_list(listname,domain)
    
You can interact with announcement lists by adding and removing subscribers
    
    # add a new subscriber to an announcement list
    account.announce_add(listname,domain,email)
    
    # remove a subscriber from an announcement list
    account.announce_remove(listname,domain,email)
    
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
     help                           # show this usage

     domains:http                       # list HTTP domain details
     domains:mysql                      # list MySQL domains
     domains:status                     # check availability of all domains (pingability)

     dns                                # list DNS records
     dns <name>                         # list DNS records for <name>
     dns:add <record> <type> <value>    # add DNS record 
     dns:remove <record> <type> <value> # remove DNS record

     announce                           # list announce lists
     announce:list <list>               # list all subscribers to <name> list
     announce:add <list> <email>        # add subscriber with <email> to <list>
     announce:remove <list> <email>     # remove subscriber with <email> from <list>

     users                              # list user accounts: details
     users:pw                           # list user accounts: usernames & passwords

     
That's it for now. New commands should be springing up as Dreamy and the DreamHost API mature!

TODO
====

* more tests
* add real rdocs

[1]:http://github.com/sant0sk1/dreamy
[2]:http://wiki.Dreamy.com/API