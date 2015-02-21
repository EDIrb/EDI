require 'spec_helper'

RSpec.describe IHeartQuotes, vcr: { cassette_name: 'i_heart_quotes', :record => :new_episodes} do
  describe "A random quote" do
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a quote please")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "Prosperity makes friends, adversity tries them.\n\t\t-- Publilius Syrus" }
  end

  describe "Simpsons Quotes" do
    let(:simpsons_response) { "Homer:\tI don't want you to see me sitting on my worthless butt.\n\nBart:\tWe've seen it, Dad.\n\n\t\t   Homer at the Bat" }
    context "Homer" do
      let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a homer quote please")) }
      subject { described_class.new message }
      it { expect(subject.invoke).to eq  simpsons_response }
    end
    context "Simpsons" do
      let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a simpsons quote please")) }
      subject { described_class.new message }
      it { expect(subject.invoke).to eq  simpsons_response }
    end
  end

  describe "Star Wars" do
    let(:star_wars_response) { "Han Solo:\n\tAfraid I was gonna leave without giving you a\n\tgoodbye kiss?\nPrincess Leia:\n\tI'd just as soon kiss a Wookiee!\nHan Solo:\n\tI can arrange that! You could use a good kiss!" }
    context "Star Wars" do
      let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a star wars quote please")) }
      subject { described_class.new message }
      it { expect(subject.invoke).to eq star_wars_response }
    end

    context "Luke" do
      let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a luke quote please")) }
      subject { described_class.new message }
      it { expect(subject.invoke).to eq star_wars_response }
    end

    context "Leia" do
      let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a leia quote please")) }
      subject { described_class.new message }
      it { expect(subject.invoke).to eq star_wars_response }
    end

    context "Vader" do
      let(:message) { Slack::Message.new(slack_outgoing_message(text: "Jarvis, a darth vader quote please")) }
      subject { described_class.new message }
      it { expect(subject.invoke).to eq star_wars_response }
    end
  end
end
