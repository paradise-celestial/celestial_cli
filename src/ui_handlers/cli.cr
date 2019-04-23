require "../ui_handler"
require "../parade"

module CelestialCLI::UIHandlers
  class CLI < UIHandler
    PROMPT_NORMAL = "> "
    PROMPT_ERROR  = "! "

    def start
      success = true
      loop do
        begin
          str = prompt(success ? PROMPT_NORMAL : PROMPT_ERROR)
          success = @parade.query str, io: STDOUT
        rescue e : Parade::Error
          puts e.message
          success = false
        end
      end
    end

    private def prompt(str)
      print str
      gets
    end
  end
end
