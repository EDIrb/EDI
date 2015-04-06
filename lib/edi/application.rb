require 'yaml'
module EDI
  class Application
    require 'active_support/dependencies'

    def self.initialize!
      add_edi_root_to_load_path
      load_variables
      autoload_paths
      require File.join EDI.root, "bot/core"
      require_initializers
      connect_websocket
    end

    def self.require_initializers
      Dir[EDI.root + '/config/initializers/*.rb'].each do |file|
        require file
      end
    end

    def self.autoload_paths
      ActiveSupport::Dependencies.autoload_paths += EDI.config.autoload_paths
    end

    def self.add_edi_root_to_load_path
      $: << EDI.root
    end

    def self.connect_websocket
      EDI.websocket.connect
    end

    def self.load_variables
      load_yaml("config/services.yml").each do |key, value|
        ENV[key] ||= value.to_s if value
      end
    end

private

    def self.load_yaml(file)
      YAML.load File.open(File.join(EDI.root, file)).read
    end

  end
end
