require "http/web_socket"
require "http/client"
require "../adapter"
require "../parade"

module CelestialCLI::Adapters
  # Adapter for Celestial servers.
  #
  # Example URIs:
  # - `https://example.com`
  # - `http://localhost:3000`
  class CelestialAdapter < Adapter
    register "http", "https"

    @socket : HTTP::WebSocket
    @client : HTTP::Client

    def initialize(uri : URI)
      @socket = HTTP::WebSocket.new uri / "socket"
      @client = HTTP::Client.new uri
    end

    def on_change(&block)
      @socket.on_message do |*args|
        yield *args
      end
    end

    def world
      # TODO
      Parade::World.new
    end
  end
end
