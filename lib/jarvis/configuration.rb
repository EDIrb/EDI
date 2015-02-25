module Jarvis
  module Configuration
    require 'active_support'
    require 'active_support/configurable'
    require 'active_support/dependencies'
    def self.included(base)
      base.include ActiveSupport::Configurable
      base.configure do |config|
        config.default_response = "What is this, I don't even"
        config.autoload_paths = ["#{Jarvis.root}/app/services"]
      end
      base.
    end
  end
end
