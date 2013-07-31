require 'spec_helper'

describe ApplicationConfigurator do
  describe 'before_method command' do
    let(:klass) {
      Class.new {
        def initialize
          @counter = 0
        end
        attr_reader :counter
        def foo
          @counter += 1
        end
      }
    }
    before(:each) do
      $receiver = []
      $other_receiver = []
      ApplicationConfigurator do |config|
        config.before_method(klass, :foo) << lambda { |object|
          $receiver << object
        }

        config.before_method(klass, :foo) << lambda { |object|
          $other_receiver << 1
        }
      end
    end
    let(:klass_instance) { klass.new }

    it 'runs the configuration block when method is called' do
      ApplicationConfigurator.configure!
      expect {
        expect {
          klass_instance.foo
        }.to change { $other_receiver }.from([]).to([1])
      }.to change { $receiver }.from([]).to([klass_instance])
      expect(klass_instance.counter).to eq(1)
    end

    it 'does not apply configuration until configurator is configured!' do
      expect {
        expect {
          klass_instance.foo
        }.to_not change { $other_receiver }
      }.to_not change { $receiver }
      expect(klass_instance.counter).to eq(1)
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
