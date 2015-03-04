require 'spec_helper'

RSpec.describe TweetThat, vcr: { cassette_name: 'tweet_that', :record => :new_episodes} do
  describe "Tweet last message" do
    before do
      stub_env "SLACK_TOKEN" => "slack_token",
      "TWITTER_ACCESS_TOKEN" => "twitter_access_token",
      "TWITTER_CONSUMER_KEY" => "twitter_consumer_key",
      "TWITTER_CONSUMER_SECRET" => "twitter_consumer_secret",
      "TWITTER_HANDLE" => "twitter_handle",
      "TWITTER_TOKEN_SECRET" => "twitter_token_secret"

    end
    let(:message) { Slack::Message.new(slack_outgoing_message(text: "EDI, tweet that", channel_id: "C0000001", user_name: "DVG")) }
    subject { described_class.new message }
    it { expect(subject.invoke).to eq "Here you are, DVG, https://twitter.com/twitter_handle/status/569329768350380032" }
  end
end
