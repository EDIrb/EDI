module Slack
  class WebsocketIncomingMessage
    attr_accessor :channel, :user, :text, :type
    def initialize(params)
      params = JSON.parse(params)
      @channel = params["channel"]
      @user = params["user"]
      @text = params["text"]
      @type = params["type"]
    end

    def to_s
      "Slack::WebsocketMessage text: #{self.text}"
    end

    def should_respond?
      message_type? && mentions_edi?
    end

    def message_type?
      type == "message"
    end

    def mentions_edi?
      if text
        text.match /edi/i
      else
        false
      end
    end
  end
end
