require 'spec_helper'

RSpec.describe Dice do
   context "d6" do
     let(:message) { Slack::Message.new slack_outgoing_message(text: "Jarvis, roll 1d6") }
     subject { described_class.new(message) }
     before { allow(subject).to receive(:roll) { 5 }}
     it { expect(subject.invoke).to eq "You got a 5" }
   end
   context "2d6" do
     let(:message) { Slack::Message.new slack_outgoing_message(text: "Jarvis, roll 2d6") }
     subject { described_class.new(message) }
     before { allow(subject).to receive(:roll).and_return(1, 6) }
     it { expect(subject.invoke).to eq "You got a 7" }
   end
   context "5d20" do
     let(:message) { Slack::Message.new slack_outgoing_message(text: "Jarvis, roll 5d20") }
     subject { described_class.new(message) }
     before { allow(subject).to receive(:roll).and_return(1, 12, 20, 3, 4) }
     it { expect(subject.invoke).to eq "You got a 40" }
   end
end
