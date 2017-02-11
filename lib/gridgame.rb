require_relative 'console'
require_relative 'row'
require_relative 'destination'
require_relative 'player'
require_relative 'game_area'

class Gridgame
  ROWS= 3
  def initialize(console = Console.new)
    @console = console
    @message = ''
    @player = Player.new 0, 2
    @game_area = GameArea.new ROWS
    @game_area.add @player
    @game_area.add Destination.new
  end

  def start
    do_display
    @console.input {|c|
      @message = ''
      if c == 'r'
        check_moved @game_area.right(@player)
      elsif c == 'l'
        check_moved @game_area.left(@player)
      elsif c == 'u'
        check_moved @game_area.up(@player)
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
    @console.output @game_area.rows.map(&:to_s) + [@message, keys]
  end

  def quit
    @console.release
  end

  def keys
    'Move: lru, Quit: q'
  end
end