require 'active_support'
require 'active_support/string_inquirer'
require 'edi/core_ext'
require "edi/version"
require 'edi/server'
require 'edi/dsl'
require 'edi/postable'
require 'edi/environment'
require 'edi/service'
require 'edi/exceptions'
require 'edi/interpreter'
require 'edi/refinements'
require 'edi/services'
require 'edi/slack'
require 'edi/api/response'
require 'edi/configuration'
require 'edi/http_utilities'
require 'edi/application'
require 'edi/utilities/array_responder'
require 'edi/schedule'
require 'edi/job'
module EDI
  class << self
    attr_accessor :services
    def services
      @services ||= []
    end

    def register_services(*args)
      args.each { |klass| services << klass}
      EDI::Interpreter.build_determine_service
    end

    def clear_services
      @services = []
    end

    def bootstrap
      require File.join EDI.root, "config", "environment"
      EDI::Application.initialize!
    end

    def root
      self.config.root
    end

    def env
      self.config.environment ||= ActiveSupport::StringInquirer.new(ENV["edi_ENV"] || ENV["RACK_ENV"] || "development")
    end

    def env=(environment)
      self.config.environment = ActiveSupport::StringInquirer.new(environment)
    end

  end
  include EDI::HTTPUtilities
  include EDI::Configuration
end
