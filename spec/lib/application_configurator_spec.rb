require 'spec_helper'

describe ApplicationConfigurator do
  let(:config_receiver) { double }
  it 'should be callable and yield' do
    expect {|config_block|
      ApplicationConfigurator(config_receiver, &config_block)
    }.to yield_with_args(config_receiver)
  end
end