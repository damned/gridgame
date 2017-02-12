require_relative 'console'
require_relative 'destination'
require_relative 'player'
require_relative 'game_area'

class Gridgame
  def initialize(console = Console.new, width: 5, height: 3)
    @console = console
    @message = ''
    @player = Player.new 0, 2
    @game_area = GameArea.new width, height
    @game_area.add @player
    @destination = Destination.new
    @game_area.add @destination
  end

  def start
    do_display
    @console.input {|c|
      @message = ''
      if c == 'q'
        quit
      else
        handle_move_key(c)
        do_display unless game_over?
      end
    }
  end

  def handle_move_key(c)
    if commands_by_key.has_key?(c)
      check_moved @game_area.send(commands_by_key[c], @player)
    end
  end

  def check_moved(moved)
    @message = 'Cannot move there' unless moved
  end

  private

  def game_over?
    if @destination.x == @player.x && @destination.y == @player.y
      game_over 'Reached destination'
      return true
    end
    false
  end

  def commands_by_key
  {
    'l' => :left,
    'r' => :right,
    'd' => :down,
    'u' => :up
  }
  end

  def do_display
    @console.output @game_area.to_a + [@message, keys]
  end

  def quit
    game_over 'Quitted game'
  end

  def game_over(message)
    @console.output [message]
    @console.release
  end

  def keys
    "Move: #{commands_by_key.keys.join ''}, Quit: q"
  end
end