require_relative 'console'

class Row
  def initialize(*actors)
    @actors = actors
  end
  def to_s
    row = '.....'
    @actors.each {|actor|
      row[actor.x] = actor.actor_to_s
    }
    row
  end
end

class DestinationRow < Row
  def initialize
    super self
  end
  def x
    3
  end
  def actor_to_s
    'X'
  end
end

class EmptyRow < Row
  def to_s
    '.....'
  end
end

class Player
  MIN_X = 0
  MAX_X = 4
  def initialize
    @player_x = MIN_X
  end
  def left
    return false if @player_x == MIN_X
    @player_x -= 1
    true
  end
  def right
    return false if @player_x == MAX_X
    @player_x += 1
  end
  def x
    @player_x
  end
  def actor_to_s
    '@'
  end
end

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
    @rows = [DestinationRow.new, EmptyRow.new, EmptyRow.new]
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