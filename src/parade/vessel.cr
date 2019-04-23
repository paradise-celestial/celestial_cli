require "yaml"

module CelestialCLI
  class Parade
    class Vessel
      def initialize(@name, @parent, *, @attr = "", @note = "", @owner = -1, @triggers = {} of String => String)
      end

      YAML.mapping(
        name: String,
        attr: {type: String, default: ""},
        note: {type: String, default: ""},
        parent: {type: Int32, setter: false, getter: false},
        owner: {type: Int32, default: -1, setter: false, getter: false},
        triggers: {type: Hash(String, String), default: {} of String => String}
      )
    end
  end
end
