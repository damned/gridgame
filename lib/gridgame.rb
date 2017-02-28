require_relative 'console'
require_relative 'actors'
require_relative 'game_area'
require_relative 'config'

class Gridgame
  def initialize(console: Console.new, config: GameConfig.new)
    @console = console
    @messages = []
    @game_area = GameArea.new config.width, config.height
    @actors = {}
    add_actors config
  end

  def start
    do_display
    @console.input {|key|
      @messages = []
      if key == 'q'
        quit
      else
        tick key
      end
    }
  end

  def tick(key)
    handle_keys(key)
    update_actors
    post_tick
    whats_here
    do_display unless game_over?
  end

  def handle_keys(key)
    handle_move_key(key)
    handle_action_key(key)
  end

  def update_actors
    @actors.values.each {|actor|
      actor.tick @game_area
    }
  end

  def post_tick
    @actors.values.each {|actor|
      actor.post_tick @game_area
    }
  end

  def handle_move_key(c)
    if moves_by_key.has_key?(c)
      check_moved @game_area.send(moves_by_key[c], player)
    end
  end

  def handle_action_key(c)
    if actions_by_key.has_key?(c)
      player.send(actions_by_key[c], @game_area)
    end
  end

  def check_moved(moved)
    add_message('Cannot move there') unless moved
  end

  private

  def whats_here
    things_here = player.whats_here_in @game_area
    add_message "You can see: #{things_here.join ', '}" unless things_here.empty?
  end

  def add_message(message)
    @messages << message
  end

  def message
    @messages.join '. '
  end

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

  def actions_by_key
  {
    't' => :take,
  }
  end

  def do_display
    @console.output @game_area.to_a + [message, status, keys]
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
    "Move: arrows, Take: t, Quit: q"
  end

  ActorClasses = {
      player: Player,
      destination: Destination,
      actor: Actor,
      blocker: Blocker,
      experience_builder: AttributeBuilder,
      charming_chain: CharmingChain
  }

  def add_actors(config)
    config.positions.each {|key, position|
      add_actor(ActorClasses[key], key, position)
    }
  end

  def add_actor(actor_class, key, position)
    raise "unknown actor type: #{key}" if actor_class.nil?

    actor = actor_class.new position
    @actors[key] = actor
    @game_area.add actor
  end

end