What is it?
===========

[Dreamy][1] is Ruby library and command line tool for interfacing with [DreamHost's API][2]. The API itself is still very young so this is by no means a comprehensive library. Please fork and contribute!

Library Usage
=============

DreamHost requires a username (email or webID) and API key (available from your DH Panel) to make API requests. When creating a Dreamy instance you'll need to provide this data. The Dreamy command line tool (dh) gathers the necessary info from a configuration file or environment variables, but you can do it however you'd like.

To get started with the library:

    gem sources -a http://gems.github.com
    gem install sant0sk1-dreamy

    require 'rubygems'
    require 'dreamy'
    
    account = Dreamy::Control.new(username,api_key)
    
    # fetch an array of Dreamy::Domain objects
    account.domains
    
    # fetch an array of Dreamy::User objects
    account.users
    
    # fetch an array of Dreamy::Dns objects
    account.dns
    
Command Line Usage
==================

The Dreamy gem will install an executable called "dh". Run this from the command line to print the usage:

    gem sources -a http://gems.github.com
    gem install sant0sk1-dreamy

    dh help
    
    === Commands

     help                         # show this usage

     domains                      # list domains
     domains:status               # check availability of all domains

     dns                          # list your DNS records
     dns <name>                   # list DNS records for <ame>

     users                        # list user accounts
     
New commands should be springing up as Dreamy and the DreamHost API mature.

[1]:http://github.com/sant0sk1/dreamy
[2]:http://wiki.Dreamy.com/API