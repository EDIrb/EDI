ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'json'
require 'jarvis'

include Rack::Test::Methods

def app
  Jarvis::Server
end

RSpec.configure do |config|
  config.expose_dsl_globally = false
end
