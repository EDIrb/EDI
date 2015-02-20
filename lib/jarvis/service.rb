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
      message.public_send(name, *args, &blk)
    end

    def run

    end

    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless (ENV[v] || ENV[v.downcase])
      end
    end

    # Class Methods
    class << self
      attr_accessor :required_environment_variables, :pattern, :interpreter_phrases, :invoker
    end

    def self.phrases(*args)
      @interpreter_phrases = args
      reset_interpreter_pattern
    end

    def self.required_environment_variables
      @required_environment_variables ||= []
    end

    def self.environment(*args)
      args.each do |sym|
        str = sym.to_s.upcase
        send :define_method, sym do
          ENV[str] || ENV[str.downcase]
        end
        required_environment_variables << str
      end
    end


    def self.interpreter_pattern(pattern)
      @pattern = pattern
    end

    def self.pattern
      @pattern ||= concatenate_phrases_into_regex
    end

    # class MyService < Jarvis::Service
    #   invoke_with :post_tweet
    #
    # end
    def self.invoke_with(method_name)
      send :define_method, :invoke do
        run_hook :before_invoke
        response = send method_name
        run_hook :after_invoke
        response
      end
    end


    private

    def self.concatenate_phrases_into_regex
      case self.interpreter_phrases
      when Array then /#{self.interpreter_phrases.join("|")}/i
      when String then /#{self.interpreter_phrases}/i
      end
    end

    def self.reset_interpreter_pattern
      @pattern = nil
    end

    invoke_with :run
    define_hooks :before_invoke, :after_invoke
  end
end
