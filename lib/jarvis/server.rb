require 'sinatra'
require "sinatra/json"
require 'json'

module Jarvis
  class Server < Sinatra::Base

    get "/" do
      json text: "Hello, I'm Jarvis"
    end

    post "/jarvis" do
      message = Slack::Message.new(params)
      service = Jarvis::Interpreter.new(message).determine_service.new
      begin
        service.validate_environment
        service.invoke
        json text: service.say
      rescue Jarvis::UnfitEnvironmentException => e
        json text: "I'm really sorry, but that sevice needs to be configured"
      rescue => e
        json text: "Something went wrong"
      end
    end

    run! if app_file == $0
  end
end
