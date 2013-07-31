require 'spec_helper'

describe ApplicationConfigurator::ConfigBuilder do
  let(:container) { double }
  subject { ApplicationConfigurator::ConfigBuilder.new(container) }

  it {
    subject
  }
end