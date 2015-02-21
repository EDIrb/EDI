require 'spec_helper'

RSpec.describe IHeartQuotes, vcr: { cassette_name: 'i_heart_quotes', :record => :new_episodes} do
  describe "A random quote" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a quote please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "Prosperity makes friends, adversity tries them.\n\t\t-- Publilius Syrus" }
  end
end
