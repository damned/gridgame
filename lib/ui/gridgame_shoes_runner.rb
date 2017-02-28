require 'shoes'
require_relative '../gridgame'
require_relative '../config/default_game_config'

class ShoesConsole
  def initialize(app)
    @app = app
  end

  def output(lines)
    @app.output lines
  end

  def input(&input_handler)
    @app.input &input_handler
  end

  def release
    @app.close
  end

end

class GridgameShoesRunner

  def run(config = DefaultGameConfig.new)
    Shoes.app(width: 400, height: 300) do

      def output(lines)
        @lines = lines
        @world.clear {
          @lines.each {|line|
            para line, font: 'Courier'
          }
        }
      end

      def input(&input_handler)
        @input_handler = input_handler
      end

      @game_console = ShoesConsole.new(self)

      @world = stack do
        para 'hello world :)'
      end

      keypress { |key|
        unless @input_handler.nil?
          @input_handler.call key.to_s
        end
      }

      @game = Gridgame.new(config: config, console: @game_console)
      @game.start
      puts 'app running'
    end
  end
end