ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require 'json'
require 'jarvis'
require 'byebug'
require 'vcr'
require_relative './support/shared_contexts/service'
require_relative './support/shared_contexts/server'
require 'jarvis/test_support/test_support'

include Rack::Test::Methods
include Jarvis::TestSupport

def app
  Jarvis::Server
end

def stub_env(hash)
  hash.each do |key, value|
    allow(ENV).to receive(:[]).with(key) { value }
  end
end

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.around(:each) do |example|
    class TestService < Jarvis::Service
      def run

      end
    end
    class OtherTestService < Jarvis::Service
      def run

      end
    end
    class TestServer < Jarvis::Server
    end

    example.run

    Jarvis.clear_services

    Object.send :remove_const, :TestServer
    Object.send :remove_const, :TestService
    Object.send :remove_const, :OtherTestService
  end
  config.include ServerContext
  config.include ServiceContext
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/fixtures/vcr_cassettes"
  config.configure_rspec_metadata!
  config.hook_into :webmock
end
