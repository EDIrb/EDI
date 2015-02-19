require 'hooks'
module Jarvis
  class Service
    include Hooks

    attr_accessor :message, :response
    def initialize(message)
      @message = message
      @response = ""
    end

    def method_missing(name, *args, &blk)
      message.public_send(name, args, blk)
    end

    def invoke
    end

    def say
    end

    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless ENV[v]
      end
    end

    # Class Methods
    class << self
      attr_accessor :required_environment_variables, :interpreter_pattern, :phrases

      def phrases=(*args)
        @phrases = args
        reset_interpreter_pattern
      end

      def required_environment_variables
        @required_environment_variables ||= []
      end

      def environment(*args)
        args.each do |sym|
          str = sym.to_s.upcase
          create_instance_method sym do
            ENV[str]
          end
          required_environment_variables << str
        end
      end

      def interpreter_pattern
        @interpreter_pattern ||= concatenate_phrases_into_regex
      end

      # class MyService < Jarvis::Service
      #   invoke_with :post_tweet
      #
      # end
      def invoke_with(method_name)
        create_instance_method(:invoke) do
          #self.run_hook :before_invoke
          self.send method_name
          #self.run_hook :after_invoke
        end
      end

    private

      def create_instance_method(name, &blk)
        self.send(:define_method, name, blk)
      end

      def concatenate_phrases_into_regex
        case phrases
        when Array then /#{phrases.join("|")}/i
        when String then /#{phrases}/i
        end
      end

      def reset_interpreter_pattern
        @interpreter_pattern = nil
      end
    end

  end
end
