require 'spec_helper'

RSpec.describe Giphy, vcr: { cassette_name: 'giphy', :record => :new_episodes} do
  before { stub_env("GIPHY_API_VERSION" => "v1", "GIPHY_API_KEY" => "key") }
  describe "Any old GIF" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, a gif please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "http://s3.amazonaws.com/giphymedia/media/10BhvFXneBD6X6/giphy.gif" }
    it { expect(subject.send(:additional_params)).to eq "" } # No tags
  end

  describe "Cat GIF" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, a cat gif please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "http://s3.amazonaws.com/giphymedia/media/4u8WdgQEMVaj6/giphy.gif" }
    it { expect(subject.send(:additional_params)).to eq "&tag=cat" }
  end

  describe "Kitty GIF" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, a Kitty gif please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "http://s3.amazonaws.com/giphymedia/media/4u8WdgQEMVaj6/giphy.gif" }
    it { expect(subject.send(:additional_params)).to eq "&tag=cat" }
  end

  describe "Sloth GIF" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, a sloth gif please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "http://s3.amazonaws.com/giphymedia/media/FsjDdnIRcroIM/giphy.gif" }
    it { expect(subject.send(:additional_params)).to eq "&tag=sloth" }
  end

  describe "Bacon GIF" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, a bacon gif please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "http://s3.amazonaws.com/giphymedia/media/La4sAOzY9H8L6/giphy.gif" }
    it { expect(subject.send(:additional_params)).to eq "&tag=bacon" }
  end

  describe "Trippy GIF" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, a trippy gif please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "http://s3.amazonaws.com/giphymedia/media/muAhZqHWt0bv2/giphy.gif" }
    it { expect(subject.send(:additional_params)).to eq "&tag=trippy" }
  end
end
