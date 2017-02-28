require_relative 'console'
require_relative '../gridgame'
require_relative '../config/default_game_config'

class GridgameConsoleRunner
  def run(config = DefaultGameConfig.new)
    Gridgame.new(config: config, console: Console.new).start
  end
end
