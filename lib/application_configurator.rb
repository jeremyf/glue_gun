require "application_configurator/version"

module ApplicationConfigurator
  module_function
  def configuration=(object)
    @configuration = object
  end
  def configuration
    @configuration
  end
  def configure!
    configuration.configure!
  end
end

def ApplicationConfigurator(config = ApplicationConfigurator::ConfigBuilder.new)
  yield(config) if block_given?
  ApplicationConfigurator.configuration = config
end

require 'application_configurator/config_builder'