require 'commands/base'

module Dreamy
  module Command
    class InvalidCommand < RuntimeError; end

    class << self
      def run(command, args)
        run_internal(command, args)
      rescue InvalidCommand
        error "Unknown command. Run 'dh help' for usage information."
      rescue ApiError
        error "DreamHost returned an error. Make sure you have a valid username & API key"
      rescue Interrupt => e
        error "\n[canceled]"
      end

      def run_internal(command, args)
        namespace, command = parse(command)
        require "commands/#{namespace}"
        klass = Dreamy::Command.const_get(namespace.capitalize).new(args)
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