require 'bundler/setup'
Bundler.require(:default)
EDI.configure do |config|
  config.root = File.expand_path "./"
  # Your bot's name, not required for anything, but you can use it to have your bot speak it's name
  # config.bot_name = "EDI"

  # Default response is what EDI will say in response to a message that doesn't have a registered service.
  # If you configure this to be an array of strings, a random one will be selected.
  # config.default_response = "What is this, I don't even"

  # Hello Message, returned when browsing to / on your bot's host
  # config.hello_message = "Hello, I'm #{config.bot_name}"

  # Message returned to slack if an unconfigured service is invoked
  # config.unfit_environment_response = "I'm really sorrt, but that service needs to be configured"

  # Message returned to slack if a third party api fails
  # config.third_party_api_failure_response = "Most unfortunately, that service is not working right now."

  # Standard Error Response sent back to slack if anything else goes wrong
  # config.standard_error_response = "I'm sorry, something went wrong."

  # Add additional autoload directories to autoload_paths
  # config.autoload_paths += "bot/models"

  # Default channel to post to using the post_to_slack method
  # config.default_channel = "#general"
end
EDI.bootstrap
