ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'json'
require 'jarvis'
require 'byebug'
require_relative './support/shared_contexts/service'
require_relative './support/shared_contexts/server'

include Rack::Test::Methods


class TestServer < Jarvis::Server
  def self.reset!
    Jarvis.clear_services
  end
end

class TestService < Jarvis::Service
  def self.reset!
    self.required_environment_variables = nil
    self.interpreter_pattern = nil
    self.phrases = nil
  end
end

class OtherTestService < Jarvis::Service
  def self.reset!
    self.required_environment_variables = nil
    self.interpreter_pattern = nil
    self.phrases = nil
  end
end

def app
  Jarvis::Server
end

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.after(:each) { TestServer.reset! }
  config.after(:each) { TestService.reset! }
  config.include ServerContext
  config.include ServiceContext
end
