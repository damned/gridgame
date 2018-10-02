require_relative '../gridgame'
require_relative '../config/default_game_config'

class OpalConsole
  def intitialize
    @release = false
  end

  def output(lines)
    lines.each {|line|
      STDOUT.puts line
    }
  end

  def input
    while true do
      c = STDIN.getc
      yield c.to_s
      break if @release
    end
  end

  def release
    @release = true
  end

end
class GridgameOpalRunner
  def run(config = DefaultGameConfig.new)
    puts 'there'
    Gridgame.new(config: config, console: OpalConsole.new).start
  end
end
GridgameOpalRunner.new.run
