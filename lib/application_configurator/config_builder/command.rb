module ApplicationConfigurator
  class ConfigBuilder
    class Command
      def initialize(builder)
        @builder = builder
      end

      def call
        raise NotImplementedError,
          "Method #call should be overriden in child classes"
      end

      protected
      def defer(&block)
        @builder.defer(&block)
      end
    end
  end
end
