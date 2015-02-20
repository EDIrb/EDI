require 'cucumber'
require 'jarvis'
require 'rack/test'
require 'byebug'
require 'json'
require 'capybara/cucumber'
require 'vcr'
require 'webmock'


include Rack::Test::Methods

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

Before do
  class Server < Jarvis::Server
  end
  Capybara.app = Server
end

After do
  Object.send :remove_const, :Server
end

def app
  Server
end

def slack_outgoing_message(options={text:"Jarvis, what's going on?"})
  {
    "team_id" => options[:team_id] || "T0001",
    "channel_id" => options[:channel_id] || "BLAH",
    "channel_name" => options[:channel_name] || "test",
    "timestamp" => options[:timestamp] || "1355517523.000005",
    "user_id" => options[:user_id] || "U2147483697",
    "user_name" => options[:user_name] || "Steve",
    "text" => options[:text],
    "trigger_word" => options[:trigger_word] || "Jarvis"
  }
end

def parsed_response(response)
  JSON.parse(response.body)["text"]
end
