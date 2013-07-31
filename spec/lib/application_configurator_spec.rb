require 'spec_helper'

describe ApplicationConfigurator do
  let(:config) { double }
  it 'should be callable and yield' do
    expect {|config_block|
      ApplicationConfigurator(config, &config_block)
    }.to yield_with_args(config)
    expect(ApplicationConfigurator.configuration).to eq(config)
  end

  it 'configure!' do
    config.should_receive(:configure!)
    ApplicationConfigurator(config)
    ApplicationConfigurator.configure!
  end
end
