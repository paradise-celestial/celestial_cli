require "../adapter"
require "./world"
require "./vessel"
require "./error"

module CelestialCLI
  class Parade
    property world : World

    def initialize(@adapter : Adapter)
      @world = @adapter.world
    end

    def query(string, io = STDOUT)
      io.puts @world.to_yaml
      true
    end
  end
end
