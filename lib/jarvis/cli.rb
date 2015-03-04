require 'thor'
require 'byebug'
module Jarvis
  class CLI < Thor
    include Thor::Actions

    attr_reader :name

    desc "new BOT_NAME", "Sets up a new Jarvis project"
    def new(name)
      @name = Thor::Util.snake_case(name)
      directory(:project, @name)
    end

    desc "start", "Bootup the Jarvis Application"
    def start(*args)
      Jarvis.config.port = args.include?("-p") ? args[args.find_index("-p")+1] : "3030"
      set_environment_stuff(args)
      ENV["JARVIS_PORT"] = Jarvis.config.port
      command = "rackup -p #{Jarvis.config.port}"
      run_command(command)
    end

    desc "generate", "Generate service NAME"
    def generate(type, name)
      @name = Thor::Util.snake_case(name)
      generate_service(@name)
    end

private

    def run_command(command)
      system(command)
    end

    def generate_service(name)
      template("services/%name%.rb.tt", "bot/services/#{name}.rb")
    end

    def set_environment_stuff(args)
      if ENV["RACK_ENV"]
        Jarvis.env = ENV["RACK_ENV"]
      else
        figure_out_environment(args)
      end
    end

    def figure_out_environment(args)
      ENV["JARVIS_ENV"] = case args
      when args.include?("production")
        puts "production"
        "production"
      when args.include?("test")
        "test"
      else
        "development"
      end
    end

  end
end
