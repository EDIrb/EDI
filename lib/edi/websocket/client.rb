require 'faye/websocket'
require 'eventmachine'

module Websocket
  class Client
    attr_accessor :ws_url, :client, :id

    def initialize
      self.id = 1
    end

    def connect
      self.ws_url = EDI.get("https://slack.com/api/rtm.start?token=#{ENV["SLACK_TOKEN"]}").response["url"]
      EM.run {

        self.client = Faye::WebSocket::Client.new(ws_url)

        client.on :open do |event|
          puts "EDI is now online"
        end

        # Respond to Messages
        client.on :message do |event|
          incoming_message = Slack::WebsocketIncomingMessage.new(event.data).message
          if incoming_message.should_respond?
            response_text = ""
            service = Proc.new { response_text = EDI.runner.new(message: incoming_message).execute }
            response = Proc.new { client.send Slack::WebsocketOutgoingMessage.new(text: response_text, channel: incoming_message.channel, id: id).to_json }
            EM.defer service, response
            increment_id
          end
        end

        # Kepp Websocket Connection Alive
        EM.add_periodic_timer(1) do
          client.ping
        end
      }
    end

private

    def increment_id
      self.id += 1
    end
  end
end
