module Jarvis
  module API
    class Response
      attr_accessor :status, :response

      def initialize(response)
        @status = response.code
        @response = response.parsed_response
      end
    end
  end
end
