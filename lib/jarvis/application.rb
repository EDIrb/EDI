module Jarvis
  class Application
    def self.initialize!
      require File.join Jarvis.root, "bot/server"
      require_initializers
    end

    def self.require_initializers
      Dir[Jarvis.root + '/config/initializers/*.rb'].each do |file|
        require file
      end
    end
  end
end
