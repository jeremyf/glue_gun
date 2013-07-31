module ApplicationConfigurator
  class ConfigBuilder
    class Command
      def self.new(builder, *args)
        builder.cached_command(*args) {
          super
        }
      end

      def initialize(builder)
        @builder = builder
        @wrappers = []
      end

      attr_reader :wrappers
      protected :wrappers
      def <<(wrapper)
        @wrappers += Array(wrapper)
      end


      def call
        raise NotImplementedError,
          "Method #call should be overriden in child classes"
      end

    end
  end
end
