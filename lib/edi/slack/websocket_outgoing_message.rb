require 'json'
module Slack
  class WebsocketOutgoingMessage
    attr_accessor :text, :channel, :type, :id
    def initialize(id: ,text:, channel:)
      @text = text
      @channel = channel
      @type = "message"
      @id = id
    end

    def to_json
      {
        text: text,
        channel: channel,
        type: type,
        id: id
      }.to_json
    end
  end
end
