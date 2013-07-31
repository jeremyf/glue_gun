require "application_configurator/version"

module ApplicationConfigurator
  # Your code goes here...
end

def ApplicationConfigurator(config_receiver)
  yield(config_receiver)
end