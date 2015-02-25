module Jarvis
  class ArrayResponder
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def respond
      case response
      when String then [response]
      when Array then response
      end.sample
    end
  end
end
