require 'cucumber'
require 'edi'
require 'rack/test'
require 'byebug'
require 'json'
require 'capybara/cucumber'
require 'vcr'
require 'webmock'
require 'edi/test_support/test_support'
require 'edi/test_support/cucumber'


include Rack::Test::Methods
include EDI::TestSupport

Before do
  class Server < EDI::Server
  end
  Capybara.app = Server
end

After do
  Object.send :remove_const, :Server
end

VCR.configure do |config|
  config.cassette_library_dir = "features/support/vcr_cassettes"
  config.hook_into :webmock
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end

def app
  Server
end
