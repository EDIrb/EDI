module Jarvis
  class Service
    class << self
      attr_accessor :required_environment_variables, :interpreter_pattern, :phrases

      def phrases=(*args)
        @phrases = args
        reset_interpreter_pattern
      end

      def required_environment(*args)
        @required_environment_variables = args
      end

      def interpreter_pattern
        @interpreter_pattern ||= concatenate_phrases_into_regex
      end

    private

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

    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless ENV[v]
      end
    end
  end
end
