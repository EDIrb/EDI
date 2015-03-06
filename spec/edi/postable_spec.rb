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
      expect(subject.new.post_to_slack("Hello World").status).to eq 200
    end
  end
end
