require 'spec_helper'

module GlueGun
  describe ConfigBuilder::Command do
    it 'is abstract' do
      command = ConfigBuilder::Command.new(ConfigBuilder.new(nil))
      expect{command.call}.to raise_error(NotImplementedError)
    end
  end
end
