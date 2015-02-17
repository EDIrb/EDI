ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'json'
require 'jarvis'

include Rack::Test::Methods

def app
  Jarvis::Server
end

def undefine_constant(const)
  Object.send(:remove_const, const)
end

def create_service(name, &blk)
  Object.const_set name, Class.new(Jarvis::Service) do
    yield
  end
end

RSpec.configure do |config|
  config.expose_dsl_globally = false
end
