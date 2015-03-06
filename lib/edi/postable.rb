module EDI
  module Postable

    module ClassMethods
      attr_accessor :post_channel
      def channel(channel)
        @post_channel = channel
      end
    end

    def actually_post(message)
      body = {
        text: message,
        channel: self.class.post_channel || "#general"
      }
      EDI.post(slack_webhook_url, body: body.to_json)
    end
    
    def post_to_slack(message)
      begin
        validate_environment
      rescue EDI::UnfitEnvironmentException
        return
      end
      actually_post(message)
    end


    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:environment, :slack_webhook_url)
    end

  end
end
