module Jarvis
  class Application
    require 'active_support/dependencies'

    def self.initialize!
      add_jarvis_root_to_load_path
      autoload_paths
      require File.join Jarvis.root, "bot/server"
      require_initializers
    end

    def self.require_initializers
      Dir[Jarvis.root + '/config/initializers/*.rb'].each do |file|
        require file
      end
    end

    def self.autoload_paths
      ActiveSupport::Dependencies.autoload_paths += Jarvis.config.autoload_paths
    end

    def self.add_jarvis_root_to_load_path
      $: << Jarvis.root
    end
  end
end
