require 'sinatra'
require "sinatra/json"
require "sinatra/multi_route"
require 'json'

module EDI
  class Server < Sinatra::Base
    register Sinatra::MultiRoute

    get "/" do
      json text: EDI::ArrayResponder.new(EDI.config.hello_message).respond
    end

    route :get, :post, "/edi" do
      message = Slack::Message.new(params)
      service = EDI::Interpreter.new(message).determine_service.new(message)
      begin
        json text: run_service(service)
      rescue EDI::UnfitEnvironmentException => e
        json text: EDI::ArrayResponder.new(EDI.config.unfit_environment_response).respond
      rescue EDI::ThirdPartyAPIFailure
        json text: EDI::ArrayResponder.new(EDI.config.third_party_api_failure_respone).respond
      rescue => e
        json text: EDI::ArrayResponder.new(EDI.config.standard_error_response).respond
      end
    end

    get "/keepalive" do
      json text: "Blah"
    end

    def self.register_services(*args)
      EDI.register_services *args
    end

private

    def run_service(service)
      service.validate_environment
      service.invoke
    end

    run! if app_file == $0
  end
end
