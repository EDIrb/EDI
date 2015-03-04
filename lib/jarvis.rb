require 'active_support'
require 'active_support/string_inquirer'
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
require 'jarvis/configuration'
require 'jarvis/http_utilities'
require 'jarvis/application'
require 'jarvis/utilities/array_responder'
require 'jarvis/scheduler'
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

    def bootstrap
      require File.join Jarvis.root, "config", "environment"
      Jarvis::Application.initialize!
    end

    def root
      self.config.root
    end

    def env
      self.config.environment ||= ActiveSupport::StringInquirer.new(ENV["JARVIS_ENV"] || ENV["RACK_ENV"] || "development")
    end

    def env=(environment)
      self.config.environment = ActiveSupport::StringInquirer.new(environment)
    end
  end
  include Jarvis::HTTPUtilities
  include Jarvis::Configuration
end
