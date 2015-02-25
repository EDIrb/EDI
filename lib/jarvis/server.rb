require 'sinatra'
require "sinatra/json"
require "sinatra/multi_route"
require 'json'

module Jarvis
  class Server < Sinatra::Base
    register Sinatra::MultiRoute

    get "/" do
      json text: "Hello, I'm Jarvis"
    end

    route :get, :post, "/jarvis" do
      message = Slack::Message.new(params)
      service = Jarvis::Interpreter.new(message).determine_service.new(message)
      begin
        json text: run_service(service)
      rescue Jarvis::UnfitEnvironmentException => e
        json text: Jarvis::ArrayResponder.new(Jarvis.config.unfit_environment_response).respond
      rescue Jarvis::ThirdPartyAPIFailure
        json text: Jarvis::ArrayResponder.new(Jarvis.config.third_party_api_failure_respone).respond
      rescue => e
        json text: Jarvis::ArrayResponder.new(Jarvis.config.standard_error_response).respond
      end
    end

    def self.register_services(*args)
      Jarvis.register_services *args
    end

private

    def run_service(service)
      service.validate_environment
      service.invoke
    end

    run! if app_file == $0
  end
end
