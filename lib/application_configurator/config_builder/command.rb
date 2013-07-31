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
    end
  end
end
