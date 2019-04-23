require "cli"
require "../config"
require "../adapter"
require "../ui_handler"
require "../version"

module CelestialCLI
  class_property config = Config.new

  class Celestial < Cli::Command
    version CelestialCLI::VERSION

    class Options
      help
      version

      arg "uri", desc: "connect to the given URI"
      string "--config", desc: "use a custom config path"
      bool %w(-g --gui), not: %w(-G --no-gui), desc: "use GUI mode", default: true
    end

    class Help
      header "A command-line interface for Celestial."
      footer "(c) 2019 microlith57 <microlith57@gmail.com>"
    end

    def run
      if args.config?
        CelestialCLI.config = Config.new args.config
      end

      uri = args.uri?
      if uri.nil?
        adapter = Adapter.default
      else
        adapter = Adapter.from_uri URI.parse(args.uri)
      end

      ui_handler = if args.gui?
                     raise "o no"
                     # UIHandlers::GUI.new adapter.world
                   else
                     UIHandlers::CLI.new adapter.parade
                   end

      ui_handler.start
    end
  end
end
