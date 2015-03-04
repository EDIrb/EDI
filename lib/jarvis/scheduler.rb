require 'rufus-scheduler'
module Jarvis
  module Scheduler
    def scheduler
      @scheduler ||= Rufus::Scheduler.new
    end

    def keepalive
      scheduler.every "30s" do
        host = if Jarvis.env.development?
          puts "http://127.0.0.1:#{Jarvis.config.port}"
          "http://127.0.0.1:#{Jarvis.config.port}"
        else
          Jarvis.host
        end
        Jarvis.get("#{host}/keepalive")
      end
    end
  end
  extend Scheduler
end
