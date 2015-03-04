# edi CLI [![Build Status](https://travis-ci.org/DVG/edi.svg?branch=master)](https://travis-ci.org/DVG/edi)

## Warning, these instructions are not true yet, but they will be!

## Installation

Add this line to your application's Gemfile:

    gem 'edi', require: 'edi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install edi

## Usage

edi is an application framework for building Chat bots to integrate with your Slack chat room. It ships with a number of useful and funny built-in services, but it also provides and easy DSL for creating your own services.

### Generating a new chat bot

Creating a chatbot is as easy as:

```bash
$ edi new my-bot
```

### Registering Services

`/bot/server.rb` is the main brain of your edi bot. Here you can register which services you want to be available on your chatbot.

```ruby
class Server < EDI::Server
  register_services :tweet_that, :img_flip, :urban_dictionary, :weather
end
```

These are the services that will be enabled when edi interprets a message from Slack.

### Required Environment Variables

If a Service integrates with an authenticated, third party API, you may need to set up environment variables for API Tokens, Secrets, Usernames and Passwords, etc. To ensure that services are not run in environments that aren't set up to support them, services can require certain variables be set up.

```ruby
class MyService < EDI::Service
  environment :service_token, :service_secret
end
```

If a service is Registered in `app/server.rb` but does not have it's expected environment, edi will throw an exception and respond with a polite refusal to execute the service. This message can be set in your EDI configuration. The enviornment method will also create a getter method for each environment variable.

### Service Routing

There are two ways to tell edi to send a given message to a particular service.`interpreter_pattern` and `phrases`

```ruby
class ImgFlip < EDI::Service
  phrases "success kid", "overly attached girlfriend"
  # will converted to a pattern that looks like /success kid|overly attached girlfriend/i
end
class SortingHat < EDI::Service
  interpreter_pattern /sorting hat|where do I belong/i
end
```

Setting interpreter pattern directly will take precendence over phrases if you include both.

### Running the Service

Services should expose a `run` method. This method will perform whatever actions necessary to fulfill the service and should ultimately return the string that edi will send back to the channel in slack.

A very simple service might look like:

```ruby
class SortingHat < EDI::Service
  def run
    [
      "Gryphondor, where dwell the brave of heart!",
      "Slytherine, because you are kind of a jerk"
    ].sample
  end
end
```

If you want to use a more semantic name for your service, you can override the method using `invoke_with`

```ruby
class IJustMetYou < EDI::Service
  invoke_with :call_me_maybe

  def call_me_maybe
    "This is crazy, but here's my number, so call me maybe"
  end
end
```

### Callbacks

You can do actions before or after the service is run, but before edi responds. For instance:

```ruby
class Joke < EDI::Service
  before_invoke :setup
  invoke_with :punch

  def setup
    Slack::Post.new(channel_id, "What do you call a fish with no eyes?").send_message
    sleep 1
  end

  def punch
    "A FSH!"
  end
end
```
## Ship List

When these things are done, we'll be ready for 1.0

- [x] Finish Porting The Services from the original bot to the framework
- [ ] Ability for edi to Post Back into the Slack Chatroom
- [ ] EDI::Schedule
- [ ] Add Test Framework to the Project Generator
- [x] Service Generator
- [x] Configure All The Things
- [x] Boot Process for the Generated App

## Contributing

1. Fork it ( https://github.com/[my-github-username]/edi_server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
