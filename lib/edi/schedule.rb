require 'rufus-scheduler'
module EDI
  module Schedule
    def schedule
      @schedule ||= Rufus::Scheduler.new
    end

    def keepalive
      schedule.every "30s" do
        host = if EDI.env.development?
          puts "http://127.0.0.1:#{EDI.config.port}"
          "http://127.0.0.1:#{EDI.config.port}"
        else
          EDI.host
        end
        EDI.get("#{host}/keepalive")
      end
    end
  end
  extend Schedule
end
