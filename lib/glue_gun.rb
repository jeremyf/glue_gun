require "glue_gun/version"

module GlueGun
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

def GlueGun(config = GlueGun::ConfigBuilder.new(GlueGun))
  yield(config) if block_given?
  GlueGun.configuration = config
end

require 'glue_gun/config_builder'