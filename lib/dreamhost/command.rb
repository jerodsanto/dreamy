require 'commands/base'

module DreamHost
  module Command
    class InvalidCommand < RuntimeError; end
    class CommandFailed  < RuntimeError; end
    class Unauthorized   < RuntimeError; end

    class << self
      def run(command, args, retries=0)
        run_internal(command, args)
      rescue InvalidCommand
        error "Unknown command. Run 'dh help' for usage information."
      rescue Unauthorized
        if retries < 3
          STDERR.puts "Authentication failure"
          run(command, args, retries+1)
        else
          error "Authentication failure"
        end
      rescue CommandFailed => e
        error e.message
      rescue Interrupt => e
        error "\n[canceled]"
      end

      def run_internal(command, args)
        namespace, command = parse(command)
        require "commands/#{namespace}"
        klass = DreamHost::Command.const_get(namespace.capitalize).new(args)
        raise InvalidCommand unless klass.respond_to?(command)
        klass.send(command)
      end

      def error(msg)
        STDERR.puts(msg)
        exit 1
      end

      def parse(command)
        parts = command.split(':')
        case parts.size
        when 1
          if namespaces.include? command
            return command, 'index'
          else
            raise InvalidCommand
          end
        when 2
          raise InvalidCommand unless namespaces.include? parts[0]
          return parts
        else
          raise InvalidCommand
        end
      end

      def namespaces
        @@namespaces ||= Dir["#{File.dirname(__FILE__)}/commands/*"].map do |namespace|
          namespace.gsub(/.*\//, '').gsub(/\.rb/, '')
        end
      end

    end

  end
end