require 'spec_helper'

RSpec.describe EDI::Postable, vcr: { cassette_name: 'postable', :record => :new_episodes} do
  subject do
    Class.new do
      include EDI::Environment
      include EDI::Postable
      channel "#testing"
    end
  end

  describe "post_to_slack" do
    before { stub_env("SLACK_WEBHOOK_URL" => "http://api.slack.com/my/webhook/url") }
    it "posts to the configured channel" do
      expect(subject.new.post_to_slack(message: "Hello World").status).to eq 200
    end
  end

  describe "Doesn't try to post if slack webhook isn't set up" do
    before { stub_env("SLACK_WEBHOOK_URL" => nil) }
    it "validates environment" do
      expect(EDI).to_not receive(:post)
      subject.new.post_to_slack message: "Hello World"
    end
  end

  describe "Can override class-level channel definition by passing channel" do
    before { stub_env("SLACK_WEBHOOK_URL" => "http://api.slack.com/my/webhook/url") }
    let(:expected_body) { {text: "Hello World", channel: "#edi_testing"}.to_json }
    it "posts with the passed in channel" do
      expect(EDI).to receive(:post).with(ENV["SLACK_WEBHOOK_URL"], :body => expected_body)
      subject.new.post_to_slack(message: "Hello World", channel: "#edi_testing")
    end
  end
end
