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

    def get(*args, &blk)
      Jarvis::API::Response.new HTTParty.get(*args, &blk)
    end

    def encode_uri(str)
      URI.encode(str)
    end

    def decode_uri(str)
      URI.decode(str)
    end
  end
end
