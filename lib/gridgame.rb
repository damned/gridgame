require_relative 'console'
require_relative 'destination'
require_relative 'player'
require_relative 'game_area'
require_relative 'game_config'

class Gridgame
  def initialize(console: Console.new, config: GameConfig.new)
    @console = console
    @message = ''
    @config = config
    @game_area = GameArea.new config.width, config.height
    @actors = {}
    add_actors
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
      check_moved @game_area.send(moves_by_key[c], player)
    end
  end

  def check_moved(moved)
    @message = 'Cannot move there' unless moved
  end

  private

  def player
    @actors[:player]
  end

  def destination
    @actors[:destination]
  end

  def game_over?
    if destination.x == player.x && destination.y == player.y
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

  def add_actors
    add_actor_if_present(Player, :player)
    add_actor_if_present(Destination, :destination)
    add_actor_if_present(Actor, :actor)
  end

  def add_actor_if_present(actor_class, key)
    position = @config.positions[key]
    unless position.nil?
      add_configured_actor(actor_class, key, position)
    end
  end

  def add_configured_actor(actor_class, key, position)
    actor = actor_class.new position
    @actors[key] = actor
    @game_area.add actor
  end
end