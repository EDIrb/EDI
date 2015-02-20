ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'json'
require 'jarvis'
require 'byebug'
require_relative './support/shared_contexts/service'
require_relative './support/shared_contexts/server'

include Rack::Test::Methods

def app
  Jarvis::Server
end

def stub_env(hash)
  hash.each do |key, value|
    allow(ENV).to receive(:[]).with(key) { value }
  end
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

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.around(:each) do |example|
    class TestService < Jarvis::Service
      def run

      end
    end
    class OtherTestService < Jarvis::Service
      def run

      end
    end
    class TestServer < Jarvis::Server
    end

    example.run

    Jarvis.clear_services

    Object.send :remove_const, :TestServer
    Object.send :remove_const, :TestService
    Object.send :remove_const, :OtherTestService
  end
  config.include ServerContext
  config.include ServiceContext
end
