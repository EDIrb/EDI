module Jarvis
  class Service
    class << self
      attr_accessor :required_environment_variables, :interpreter_pattern
      def required_environment(*args)
        @required_environment_variables = args
      end
    end

    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless ENV[v]
      end
    end
  end
end
