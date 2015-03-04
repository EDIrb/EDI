module EDI
  module API
    class Response
      require 'json'
      attr_accessor :status, :response

      def initialize(response)
        @status = response.code
        @response = response.body
      end

      def response
        JSON.parse @response
      end

      def unparsed_response
        @response
      end

    end
  end
end
