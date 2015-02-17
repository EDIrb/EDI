require "jarvis/version"
require 'jarvis/server'
require 'jarvis/service'
require 'jarvis/exceptions'

module Jarvis
  class << self

    attr_accessor :services
    def services
      @services ||= []
    end

    def register(klass)
      services << klass
    end

  end
end
