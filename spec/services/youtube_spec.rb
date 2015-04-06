require 'spec_helper'

RSpec.describe Youtube, vcr: { cassette_name: 'youtube' } do
  let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, youtube Harry Potter and the Half Blood Prince")) }
  subject { described_class.new message }
  it { expect(subject.invoke).to match /https:\/\/youtu.be/ }
end
