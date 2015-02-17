# Jarvis CLI

## Warning, these instructions are not true yet, but they will be!

## Installation

Add this line to your application's Gemfile:

    gem 'jarvis-cli', require: 'jarvis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jarvis-cli

## Usage

Jarvis is an application framework for building Chat bots to integrate with your Slack chatroom. It ships with a number of useful and funny built-in services, but it also provides and easy DSL for creating your own services.

### Generating a new chat bot

Creating a chatbot is as easy as:

```bash
$ jarvis new my-bot
```

### Registering Services

`/app/server.rb` is the main brain of your Jarvis bot. Here you can register which services you want to be available on your chatbot.

```ruby
class MyBot < Jarvis::Server
  register_services Twitter, ImgFlip, UrbanDictionary, Weather
end
```

These are the services that will be enabled when Jarvis interprets a message from Slack.

### Required Environment Variables

If a Service integrates with an authenticated, third party API, you may need to set up environment variables for API Tokens, Secrets, Usernames and Passwords, etc. To ensure that services are not run in environments that aren't set up to support them, services can require certain variables be set up.

```ruby
class MyService < Jarvis::Service
  required_environment "SERVICE_TOKEN", "SERVICE_SECRET"
end
```

If a service is Registered in `app/server.rb` but does not have it's expected environment, Jarvis will throw an exception and respond with a polite refusal to execute the service. This message can be set in your Jarvis configuration.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jarvis_server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
