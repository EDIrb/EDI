require 'spec_helper'

RSpec.describe Weather, vcr: { cassette_name: 'weather', :record => :new_episodes} do
  describe "Providing a ZIP" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, what's the weather in 90210")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "Sky is clear. The temperature is currently 60" }
  end

  describe "Default Location" do
    before {stub_env('DEFAULT_LOCATION' => "43123")}
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, what's the weather")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "Light rain. The temperature is currently 35" }
  end

end
