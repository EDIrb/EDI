module EDI
  class Application
    require 'active_support/dependencies'

    def self.initialize!
      add_jarvis_root_to_load_path
      autoload_paths
      require File.join EDI.root, "bot/server"
      require_initializers
      initialize_hostname_and_port
      start_keepalive
    end

    def self.initialize_hostname_and_port
      if EDI.env.development?
        EDI.config.host = "http://127.0.0.1"
        EDI.config.port ||= ENV["JARVIS_PORT"]
      end
    end

    def self.require_initializers
      Dir[EDI.root + '/config/initializers/*.rb'].each do |file|
        require file
      end
    end

    def self.autoload_paths
      ActiveSupport::Dependencies.autoload_paths += EDI.config.autoload_paths
    end

    def self.add_jarvis_root_to_load_path
      $: << EDI.root
    end

    def self.start_keepalive
      EDI.keepalive if EDI.config.attempt_keepalive
    end
  end
end
