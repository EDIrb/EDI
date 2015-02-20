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
        json text: "I'm really sorry, but that sevice needs to be configured"
      rescue => e
        json text: "I'm sorry, Something went wrong"
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
