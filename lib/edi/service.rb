module EDI
  class Service
    include ::EDI::DSL

    attr_accessor :message, :response
    def initialize(message)
      @message = message
      @response = ""
    end

    def method_missing(name, *args, &blk)
      message.public_send(name, *args, &blk)
    end

    def run

    end

  end
end
