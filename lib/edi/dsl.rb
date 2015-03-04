require 'hooks'
module EDI
  module DSL
    module ClassMethods
      attr_accessor :required_environment_variables, :pattern, :interpreter_phrases, :invoker
      def phrases(*args)
        @interpreter_phrases = args
        reset_interpreter_pattern
      end
      def required_environment_variables
        @required_environment_variables ||= []
      end
      def environment(*args)
        args.each do |sym|
          str = sym.to_s.upcase
          send :define_method, sym do
            ENV[str] || ENV[str.downcase]
          end
          required_environment_variables << str
        end
      end

      def interpreter_pattern(pattern)
        @pattern = pattern
      end

      def pattern
        @pattern ||= concatenate_phrases_into_regex
      end

      # class MyService < EDI::Service
      #   invoke_with :post_tweet
      #
      # end
      def invoke_with(method_name)
        send :define_method, :invoke do
          run_hook :before_invoke
          @response = send method_name
          run_hook :after_invoke
          @response
        end
      end
      private

      def concatenate_phrases_into_regex
        case interpreter_phrases
        when Array then /#{interpreter_phrases.join("|")}/i
        when String then /#{interpreter_phrases}/i
        end
      end

      def reset_interpreter_pattern
        @pattern = nil
      end
    end

    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless (ENV[v] || ENV[v.downcase])
      end
    end

    def run
    end

    def self.included(base)
      base.send(:include, Hooks)
      base.send(:extend, ClassMethods)
      base.send(:invoke_with, :run)
      base.send(:define_hooks, :before_invoke, :after_invoke)
    end

  end
end
