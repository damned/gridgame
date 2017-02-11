require_relative 'console'
require_relative 'row'
require_relative 'destination'
require_relative 'player'

class Gridgame
  def initialize(console = Console.new)
    @console = console
    @message = ''
    @player = Player.new 0, 2
    @rows = [Row.new(Destination.new), Row.new, Row.new(@player)]
  end

  def start
    do_display
    @console.input {|c|
      @message = ''
      if c == 'r'
        check_moved(@player.right)
      elsif c == 'l'
        check_moved(@player.left)
      elsif c == 'u'
        @rows[@player.y].remove(@player)
        check_moved(@player.up)
        @rows[@player.y].add(@player)
      elsif c == 'q'
        quit
      end
      do_display
    }
  end

  def check_moved(moved)
    @message = 'Cannot move there' unless moved
  end

  private

  def do_display
    @console.output game_area + [@message, keys]
  end

  def game_area
    @rows.map(&:to_s)
  end

  def player_row
    @player_row
  end

  def quit
    @console.release
  end

  def keys
    'Move: lru, Quit: q'
  end
end