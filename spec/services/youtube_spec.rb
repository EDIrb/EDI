require 'spec_helper'

RSpec.describe Youtube, vcr: { cassette_name: 'youtube', record: :new_episodes } do
  let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, youtube Harry Potter and the Half Blood Prince")) }
  subject { described_class.new message }
  before { stub_env "GOOGLE_API_KEY" => "some_token" }
  it { expect(subject.invoke).to match /https:\/\/youtu.be/ }
end
