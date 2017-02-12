require_relative 'console'
require_relative 'destination'
require_relative 'player'
require_relative 'game_area'
require_relative 'game_config'

class Gridgame
  def initialize(console: Console.new, config: GameConfig.new)
    @console = console
    @message = ''
    @player = Player.new config.positions[:player]
    @game_area = GameArea.new config.width, config.height
    @game_area.add @player
    @destination = Destination.new config.positions[:destination]
    @game_area.add @destination
    actor_position = config.positions[:actor]
    unless actor_position.nil?
      actor = Actor.new actor_position
      @game_area.add actor
    end
    @actor = actor
  end

  def start
    do_display
    @console.input {|key|
      @message = ''
      if key == 'q'
        quit
      else
        handle_move_key(key)
        do_display unless game_over?
      end
    }
  end

  def handle_move_key(c)
    if moves_by_key.has_key?(c)
      check_moved @game_area.send(moves_by_key[c], @player)
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

  def moves_by_key
  {
    'left' => :left,
    'right' => :right,
    'down' => :down,
    'up' => :up
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
    "Move: arrows, Quit: q"
  end
end