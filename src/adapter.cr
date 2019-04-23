require "./uri"
require "./parade"

module CelestialCLI
  # Defines an adapter for a Celestial file, server, or other datasource.
  abstract class Adapter
    abstract def initialize(uri : URI)

    # Run the given block every time the server changes the world
    abstract def on_change(&on_change : Hash(String, Int32) ->)

    # Get this adapter's parade
    def parade
      Parade.new self
    end

    # Get this adapter's world
    abstract def world

    def to_s
      self.class.name
    end

    # Get the default adapter.
    def self.default
      self.from_uri CelestialCLI.config.default_uri
    end

    # Get the `Adapter` for the specified URI.
    def self.from_uri(uri : URI)
      Registry[uri.scheme].new(uri)
    end

    # Get the `Adapter` for the specified URI string.
    def self.from_uri(string : String)
      self.from_uri URI.parse string
    end

    # Get the default `Adapter`.
    def self.from_uri(uri : Nil)
      self.default
    end

    # A registry of all `Adapter`s.
    module Registry
      # A list of schemes and their `Adapter`s
      @@adapters = {} of String => Adapter.class

      # Register an `Adapter` class.
      def self.register(scheme, adapter)
        @@adapters[scheme] = adapter
      end

      # Get an `Adapter` from the registry.
      #
      # Usage:
      #     Registry["file"] # ==> FileAdapter
      def self.[](scheme)
        self[scheme]?.not_nil!
      end

      # Get an `Adapter` from the registry, or nil.
      #
      # Usage:
      #     Registry["file"]?    # ==> FileAdapter
      #     Registry["invalid"]? # ==> nil
      def self.[]?(scheme)
        @@adapters[scheme]?
      end
    end

    # Register the current `Adapter` with the given scheme.
    private def self.register(scheme : String)
      Registry.register scheme, self
    end

    # Register the current `Adapter` with the given schemes.
    private def self.register(schemes : Array(String))
      schemes.each do |scheme|
        self.register scheme
      end
    end

    # ditto
    private def self.register(*schemes)
      schemes.each do |scheme|
        self.register scheme
      end
    end
  end
end
