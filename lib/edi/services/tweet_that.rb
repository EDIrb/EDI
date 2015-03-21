# Tweet
require 'twitter'
class TweetThat < EDI::Service
  phrases "tweet that", "post that to twitter"
  environment :slack_token,
    :twitter_handle,
    :twitter_consumer_key,
    :twitter_consumer_secret,
    :twitter_access_token,
    :twitter_token_secret

  before_invoke :get_last_message_from_slack
  before_invoke :initialize_twitter

  attr_accessor :last_message, :twitter_client, :tweet

  def run
    self.tweet = post_tweet
    "#{link}"
  end

private

  def link
    "https://twitter.com/#{twitter_handle}/status/#{self.tweet.id}"
  end

  def post_tweet
    self.twitter_client.update self.last_message
  end

  def get_last_message_from_slack
    self.last_message = EDI.get("#{host}#{endpoint}?#{request}").response["messages"][1]["text"]
  end

  def initialize_twitter
    self.twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_consumer_key
      config.consumer_secret     = twitter_consumer_secret
      config.access_token        = twitter_access_token
      config.access_token_secret = twitter_token_secret
    end
  end

  def request
    [token, channel, count].join("&")
  end

  def host
    "https://slack.com/api/"
  end

  def endpoint
    "channels.history"
  end

  def token
    "token=#{slack_token}"
  end

  def channel
    "channel=#{channel_id}"
  end

  def count
    "count=2"
  end
end
