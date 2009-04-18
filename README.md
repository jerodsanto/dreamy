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

To get started with the library:

    require 'rubygems'
    require 'dreamy'
    
    account = Dreamy::Base.new(username,api_key)
    
    # fetch an array of Dreamy::Domain objects
    account.domains
    
    # fetch an array of Dreamy::User objects
    account.users
    
    # fetch an array of Dreamy::Dns objects
    account.dns
    
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

     help                         # show this usage

     domains                      # list domains
     domains:status               # check availability of all domains

     dns                          # list your DNS records
     dns <name>                   # list DNS records for <ame>

     users                        # list user accounts
     
That's it for now. New commands should be springing up as Dreamy and the DreamHost API mature!

TODO
====

* more tests
* create rdocs
* mailing lists

[1]:http://github.com/sant0sk1/dreamy
[2]:http://wiki.Dreamy.com/API