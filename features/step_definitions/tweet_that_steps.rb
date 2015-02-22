


Given(/^the Tweet That is configured$/) do
  stub_env "SLACK_TOKEN" => "slack_token",
  "TWITTER_ACCESS_TOKEN" => "twitter_access_token",
  "TWITTER_CONSUMER_KEY" => "twitter_consumer_key",
  "TWITTER_CONSUMER_SECRET" => "twitter_consumer_secret",
  "TWITTER_HANDLE" => "twitter_handle",
  "TWITTER_TOKEN_SECRET" => "twitter_token_secret"
end

When(/^the user (.+) post a message to the general channel saying "(.*?)"$/) do |user_name, message|
  @response = post("/jarvis", slack_outgoing_message(text: message, channel_id: general_channel_id, user_name: user_name))
end

def general_channel_id
  "C0000001"
end
