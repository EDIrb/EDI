require 'spec_helper'

RSpec.describe Fact, vcr: { cassette_name: 'fact' } do
  let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, fact")) }
  subject { described_class.new message }
  it { expect(subject.invoke).to eq "182 is the carat of the Star of Bombay cabochon-cut star sapphire originating from Sri Lanka." }
end
