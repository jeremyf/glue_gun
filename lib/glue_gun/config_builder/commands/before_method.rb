require 'glue_gun/config_builder/command'
module GlueGun
  class ConfigBuilder
    module Commands
      class BeforeMethod < GlueGun::ConfigBuilder::Command

        attr_reader :klass, :method_name
        def initialize(builder, klass, method_name)
          @klass = klass
          @method_name = method_name
          super(builder)
        end

        def call
          klass.module_exec(method_name, method_to_wrap, wrappers) { |name, method, procs|
            define_method(name) { |*args, &block|
              procs.each {|proc| proc.call(self) }
              method.bind(self).call(*args, &block)
            }
          }
        end
        private
          def method_to_wrap
            klass.instance_method(method_name)
          end
      end
    end
  end
end
