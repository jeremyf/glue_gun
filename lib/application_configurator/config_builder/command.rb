module ApplicationConfigurator
  class ConfigBuilder
    class Command
      def self.new(builder, *args, &block)
        builder.cached_command(*args) {
          super
        }
      end

      def initialize(builder)
        @builder = builder
      end

      def call
        raise NotImplementedError,
          "Method #call should be overriden in child classes"
      end

    end
  end
end
