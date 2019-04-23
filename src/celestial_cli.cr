require "./config"
require "./adapters/*"
require "./ui_handlers/*"
require "./command"

# A command line interface for Celestial.
module CelestialCLI
end

CelestialCLI::Celestial.run ARGV
