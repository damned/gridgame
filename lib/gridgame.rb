require_relative 'console'
require_relative 'actors'
require_relative 'game_area'
require_relative 'game_config'

class Gridgame
  def initialize(console: Console.new, config: GameConfig.new)
    @console = console
    @message = ''
    @game_area = GameArea.new config.width, config.height
    @actors = {}
    add_actors config
  end

  def start
    do_display
    @console.input {|key|
      @message = ''
      if key == 'q'
        quit
      else
        tick key
      end
    }
  end

  def tick(key)
    handle_move_key(key)
    update_actors
    do_display unless game_over?
  end

  def update_actors
    @actors.values.each {|actor|
      actor.tick @game_area
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
    @console.output @game_area.to_a + [@message, status, keys]
  end

  def status
    "Player: #{player.status}"
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

  ActorClasses = {
      player: Player,
      destination: Destination,
      actor: Actor,
      blocker: Blocker
  }

  def add_actors(config)
    config.positions.each {|key, position|
      add_actor(ActorClasses[key], key, position)
    }
  end

  def add_actor(actor_class, key, position)
    actor = actor_class.new position
    @actors[key] = actor
    @game_area.add actor
  end

end