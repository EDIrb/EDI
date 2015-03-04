require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)
EDI.configure do |config|
  config.root = File.expand_path "./"
  # Default response is what EDI will say in response to a message that doesn't have a registered service.
  # If you configure this to be an array of strings, a random one will be selected.
  # config.default_response = "What is this, I don't even"

  # Add additional autoload directories to autoload_paths
  # config.autoload_paths += "bot/models"
end
EDI.bootstrap
