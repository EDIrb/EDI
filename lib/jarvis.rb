require 'active_support'
require 'jarvis/core_ext'
require "jarvis/version"
require 'jarvis/server'
require 'jarvis/service'
require 'jarvis/exceptions'
require 'jarvis/interpreter'
require 'jarvis/services'
require 'jarvis/slack'

module Jarvis
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

  end
end
