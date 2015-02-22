module Jarvis
  module TestSupport
    require 'rspec/mocks'

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

    def stub_env(hash)
      stub_const('ENV', ENV.to_hash.merge(hash))
    end

  end
end
