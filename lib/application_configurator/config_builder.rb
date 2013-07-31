require 'application_configurator/config_builder/command'
module ApplicationConfigurator
  class ConfigBuilder
    def initialize(context)
      @context = context
    end

    def method_missing(method_name, *args, &block)
      command_name = command_name_for_method(method_name)
      if Commands.const_defined?(command_name)
        command_class = Commands.const_get(command_name)
        command_class.new(self, *args, &block).call
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

    private

      def command_name_for_method(method_name)
        method_name.to_s.gsub(/(?:^|_)([a-z])/) { $1.upcase }
      end

  end
end
