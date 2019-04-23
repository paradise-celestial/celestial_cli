require "http/web_socket"
require "../adapter"
require "../parade"

module CelestialCLI::Adapters
  # Adapter for local files.
  #
  # Example URIs:
  # - `file:default.teapot`
  # - `file:///home/username/default.teapot`
  class FileAdapter < Adapter
    register "file"

    def initialize(uri : URI)
      @path = Path[uri.host || "" + uri.path || ""]
      unless @path.absolute?
        @path = Path[CelestialCLI.config.worlds_folder] / @path
      end
    end

    def on_change(&on_change : Hash(String, Int32) ->)
    end

    def world
      Parade::World.read @path
    end
  end
end
