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

    def run

    end

    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless ENV[v]
      end
    end

    # Class Methods
    class << self
      attr_accessor :required_environment_variables, :interpreter_pattern, :phrases, :invoker

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
          send :define_method, sym do
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
        send :define_method, :invoke do
          run_hook :before_invoke
          send method_name
        end
      end


      private

      def concatenate_phrases_into_regex
        case self.phrases
        when Array then /#{self.phrases.join("|")}/i
        when String then /#{self.phrases}/i
        end
      end

      def reset_interpreter_pattern
        @interpreter_pattern = nil
      end
    end

    invoke_with :run
    define_hooks :before_invoke, :after_invoke
  end
end
