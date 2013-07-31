require 'spec_helper'

module ApplicationConfigurator
  class ConfigBuilder
    module Commands
      class TestCommand
      end
    end
  end

  describe ConfigBuilder do

    let(:container) { double }
    subject { ApplicationConfigurator::ConfigBuilder.new(container) }

    it 'responds to commands defined in ConfigBuilder::Commands' do
      expect(subject).to respond_to(:test_command)
    end

    it 'translates method calls into command invocations including arguments' do
      test_command = double
      ConfigBuilder::Commands::TestCommand.should_receive(:new).
        with(subject, "foo", 42).
        and_return(test_command)
      expect(subject.test_command("foo", 42)).to eq(test_command)
    end

    it 'handles missing non-command missing methods normally' do
      expect(subject).not_to respond_to(:nonexistant_method)
      expect{subject.nonexistent_method}.to raise_error(NoMethodError)
    end

  end
end
