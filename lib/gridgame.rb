require_relative 'console'
require_relative 'row'
require_relative 'destination'
require_relative 'player'

class Gridgame
  def initialize(console = Console.new)
    @console = console
    @message = ''
    @player_row_index = 2
    @player = Player.new
    @player_row = Row.new @player
    update_rows
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
        @player_row_index -= 1
        update_rows
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

  def update_rows
    @rows = [Row.new(Destination.new), Row.new, Row.new]
    @rows[@player_row_index] = @player_row
  end

  def player_row
    @player_row
  end

  def quit
    @console.release
  end

  def keys
    'Move: lr, Quit: q'
  end
end