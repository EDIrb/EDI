require 'active_support'
require 'jarvis/core_ext'
require "jarvis/version"
require 'jarvis/server'
require 'jarvis/service'
require 'jarvis/exceptions'
require 'jarvis/interpreter'
require 'jarvis/refinements'
require 'jarvis/services'
require 'jarvis/slack'
require 'jarvis/api/response'
require 'httparty'
require 'uri'
require 'active_support/configurable'

module Jarvis
  include HTTParty
  include ActiveSupport::Configurable

  self.configure do |config|
  end

  class << self

    attr_accessor :services
    def services
      @services ||= []
    end

    def register_services(*args)
      args.each { |klass| services << klass}
      Jarvis::Interpreter.build_determine_service
    end

    def clear_services
      @services = []
    end

    # HTTP Requests
    def get(path, options={}, &block)
      Jarvis::API::Response.new HTTParty.get(path, options, &block)
    end

    def post(path, options={}, &block)
      Jarvis::API::Response.new HTTParty.post(path, options, &block)
    end

    def patch(path, options={}, &block)
      Jarvis::API::Response.new HTTParty.patch(path, options, &block)
    end

    def put(path, options={}, &block)
      Jarvis::API::Response.new HTTParty.put(path, options, &block)
    end

    def delete(path, options={}, &block)
      Jarvis::API::Response.new HTTParty.delete(path, options, &block)
    end

    def encode_uri(str)
      URI.encode(str)
    end

    def decode_uri(str)
      URI.decode(str)
    end
  end
end
