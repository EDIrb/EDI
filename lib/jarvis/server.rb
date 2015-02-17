require 'sinatra'
require "sinatra/json"
require 'json'

module Jarvis
  class Server < Sinatra::Base

    get "/" do
      json text: "Hello, I'm Jarvis"
    end

    run! if app_file == $0
  end
end
