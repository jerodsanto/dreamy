require 'rubygems'
require 'terminal-table/import'

module DreamHost::Command
  class Base
    
    attr_accessor :args
    def initialize(args)
      @args     = args
      @account  = configure_account 
    end

    def display(msg, newline=true)
      if newline
        puts(msg)
      else
        print(msg)
        STDOUT.flush
      end
    end

    def ask
      gets.strip
    end

    def shell(cmd)
      `cd '#{Dir.pwd}' && #{cmd}`
    end

    def extract_option(options, default=true)
      values = options.is_a?(Array) ? options : [options]
      return unless opt_index = args.select { |a| values.include? a }.first
      opt_position = args.index(opt_index) + 1
      if args.size > opt_position && opt_value = args[opt_position]
        if opt_value.include?('--')
          opt_value = nil
        else
          args.delete_at(opt_position)
        end
      end
      opt_value ||= default
      args.delete(opt_index)
      block_given? ? yield(opt_value) : opt_value
    end

    def home_directory
      running_on_windows? ? ENV['USERPROFILE'] : ENV['HOME']
    end

    def running_on_windows?
      RUBY_PLATFORM =~ /mswin32/
    end
    
    private
    
    def configure_account
			DreamHost::Control.new(user,key)
    end
    
    def user
      get_credentials
      @credentials[0]
    end
    
    def key
      get_credentials
      @credentials[1]
    end
    
    def credentials_file
			"#{home_directory}/.dreamhostrc"
		end
		
		def read_credentials
		  if File.exists? credentials_file
				return File.read(credentials_file).split("\n")
			end
		end
    
    def get_credentials
      return if @credentials
      unless @credentials = read_credentials
        @credentials = [ENV['DH_USER'], ENV['DH_KEY']]
      end
      if @credentials[0].nil? || @credentials[1].nil?
        display "\nYou need to set your API credentials. You can do this 2 ways:\n"
        display "\n1) set environment variables 'DH_USER' and 'DH_KEY'"
        display "2) create file ~/.dreamhostrc with user on first line and key on second\n\n"
        exit 1
      end
      @credentials
    end
    

  end

end