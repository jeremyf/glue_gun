require 'glue_gun/config_builder/commands'
module GlueGun
  class ConfigBuilder
    attr_reader :operations
    def initialize(context)
      @context = context
    end

    def method_missing(method_name, *args, &block)
      command_name = command_name_for_method(method_name)
      if Commands.const_defined?(command_name)
        command_class = Commands.const_get(command_name)
        command_class.new(self, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private=false)
      command_name = command_name_for_method(method_name)
      Commands.const_defined?(command_name) || super
    rescue NameError
      super
    end

    def configure!
      deferred_commands.each { |commands| commands.call }
    end

    def cached_command(*args)
      if cached_value = deferred_commands.detect {|command| command == args }
        cached_value
      else
        command = yield
        deferred_commands << command
        command
      end
    end

    private

      def command_name_for_method(method_name)
        method_name.to_s.gsub(/(?:^|_)([a-z])/) { $1.upcase }
      end

      def deferred_commands
        @deferred_commands ||= []
      end
  end
end