require 'application_configurator/config_builder/command'
module ApplicationConfigurator
  class ConfigBuilder
    module Commands
      class BeforeMethod < ApplicationConfigurator::ConfigBuilder::Command
        attr_reader :klass, :method_name, :configuration_proc
        def initialize(builder, klass, method_name, &configuration_proc)
          super(builder)
          @klass = klass
          @method_name = method_name
          @configuration_proc = configuration_proc
        end

        def call
          defer do
            klass.module_exec(method_name, method_to_wrap, configuration_proc) { |name, method, proc|
              define_method(name) { |*args, &block|
                proc.call(self)
                method.bind(self).call(*args, &block)
              }
            }
          end
        end
        private
        def method_to_wrap
          klass.instance_method(method_name)
        end
      end
    end
  end
end
