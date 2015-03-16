module EDI
  module Postable

    module ClassMethods
      attr_accessor :post_channel
      def channel(channel)
        @post_channel = channel
      end
    end

    private
    def _actually_post(message:, channel: nil)
      body = {
        text: message,
        channel: channel || self.class.post_channel || "#general"
      }
      EDI.post(slack_webhook_url, body: body.to_json)
    end

    public
    def post_to_slack(message:, channel: nil)
      begin
        validate_environment
      rescue EDI::UnfitEnvironmentException
        return
      end
      _actually_post(message: message, channel: channel)
    end


    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:environment, :slack_webhook_url)
    end

  end
end
