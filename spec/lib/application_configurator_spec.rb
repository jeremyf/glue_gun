require 'spec_helper'

describe ApplicationConfigurator do
  describe 'before_method command' do
    let(:klass) {
      Class.new {
        def foo; end
      }
    }
    before(:each) do
      $receiver = []
      ApplicationConfigurator do |config|
        config.before_method(klass, :foo) do |object|
          $receiver << object
        end
      end
      ApplicationConfigurator.configure!
    end
    let(:klass_instance) { klass.new }

    it 'runs the configuration block when method is called' do
      klass_instance
      expect {
        klass_instance.foo
      }.to change { $receiver }.from([]).to([klass_instance])
    end
  end



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
