require 'spec_helper'

RSpec.describe Eightball do

  let(:message) { Slack::Message.new slack_outgoing_message(text: "Jarvis, will I ship this gem today?")}
  subject { described_class.new(message) }
  before { allow_any_instance_of(Array).to receive(:sample) { "Outlook not so good" } }
  specify { expect(subject.invoke).to eq "Outlook not so good" }
end
