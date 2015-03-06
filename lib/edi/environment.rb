module EDI
  module Environment

    module ClassMethods
      attr_accessor :required_environment_variables

      def environment(*args)
        args.each do |sym|
          str = sym.to_s.upcase
          send :define_method, sym do
            ENV[str] || ENV[str.downcase]
          end
          required_environment_variables << str
        end
      end
      
      def required_environment_variables
        @required_environment_variables ||= []
      end

    end
    
    def validate_environment
      self.class.required_environment_variables.each do |v|
        raise UnfitEnvironmentException unless (ENV[v] || ENV[v.downcase])
      end
    end

    def self.included(base)
      base.send(:extend, ClassMethods)
    end
  end
end
