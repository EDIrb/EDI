require 'thor'
module Jarvis
  class CLI < Thor
    include Thor::Actions

    desc "new BOT_NAME", "Sets up a new Jarvis project"
    def new(name)
      @name = Thor::Util.snake_case(name)
      directory(:project, @name)
    end

    desc "start", "Starts the server in style!"
    def start(*args)
      port_option = args.include?('-p') ? '' : ' -p 3030'
      command = "rackup #{port_option}"
      run_command(command)
    end

private

    def run_command(command)
      system(command)
    end
  end
end
