module Jarvis
  class Interpreter
    attr_accessor :text
    def initialize(text)
      @text = text
    end


private

    def self.build_determine_service
      determine_service = <<-code
        def determine_service
          case text
      code
      Jarvis.services.each do |service|
        constant = service.constantize
        determine_service += <<-code
          when #{constant.interpreter_pattern.inspect} then #{constant}
        code
      end
      determine_service += <<-code
          else
            NullService
          end
        end
      code
      self.class_eval determine_service
    end
  end
end
