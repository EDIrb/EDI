module Jarvis
  module Configuration
    require 'active_support'
    require 'active_support/configurable'
    require 'active_support/dependencies'
    def self.included(base)
      base.include ActiveSupport::Configurable
      base.configure do |config|
        config.default_response = "What is this, I don't even"
        config.unfit_environment_response = "I'm really sorry, but that service needs to be configured"
        config.third_party_api_failure_respone = "Most unfortunately, that service is not working right now."
        config.standard_error_response = "I'm sorry, Something went wrong."
        config.autoload_paths = ["#{Jarvis.root}/app/services"]
      end
    end
  end
end
