require "yaml"
require "uri"

module CelestialCLI
  class Config
    property default_uri = "file://default.teapot"
    property worlds_folder = (Config.default_folder / "worlds").to_s

    def self.new(path : String | Path | Nil = nil)
      case path
      when Path   then path = path
      when String then path = Path[path]
      when .nil?  then path = self.default_file
      end

      self.create_config_file(path) unless File.exists?(path)

      File.open(path) do |file|
        self.from_yaml file
      end
    end

    def initialize(@default_uri = URI.parse "file://default.teapot", @worlds_folder = self.default_folder / "worlds")
    end

    def self.default_folder
      Path[ENV["XDG_CONFIG_HOME"]? || "~/.config"].expand / "celestial_cli"
    end

    def self.default_file
      self.default_folder / "config.yml"
    end

    def self.create_config_file(path)
      Dir.mkdir_p self.default_folder.to_s

      File.open(path, "w+") do |file|
        file << <<-YAML
          default_uri: file://default.teapot

        YAML
      end
    end

    YAML.mapping(
      default_uri: {type: String, default: "file://default.teapot"},
      worlds_folder: {type: String, default: (Config.default_folder / "worlds").to_s}
    )
  end
end
