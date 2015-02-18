require "jarvis/version"
require 'jarvis/server'
require 'jarvis/service'
require 'jarvis/exceptions'
require 'jarvis/interpreter'

module Jarvis
  class << self

    attr_accessor :services
    def services
      @services ||= []
    end

    def register_services(*args)
      args.each { |klass| services << klass}
    end

    def clear_services
      @services = []
    end

  end
end
