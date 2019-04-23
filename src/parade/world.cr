require "yaml"
require "./vessel"

module CelestialCLI
  class Parade
    class World
      # Create a new `World`. A world has many `Vessel`s and a timestamp of its
      # last modification (in UTC).
      def initialize(@vessels = [] of Vessel, @timestamp = Time.utc_now)
      end

      YAML.mapping(
        vessels: Array(Vessel),
        timestamp: Time
      )

      def self.read(path : Path | String)
        path = Path[path] if path.is_a? String

        Dir.mkdir_p path.parent.to_s

        if !File.exists?(path.to_s) || File.empty?(path.to_s)
          instance = new
          File.open path.to_s, "w" do |file|
            instance.to_yaml file
          end
          return instance
        end

        File.open path.to_s do |file|
          self.from_yaml file
        end
      end
    end
  end
end
