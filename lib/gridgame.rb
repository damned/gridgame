require_relative 'console'

class DestinationRow
  def to_s
    '...X.'
  end
end

class EmptyRow
  def to_s
    '.....'
  end
end

class PlayerRow
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
  def to_s
    row = '.....'
    row[@player_x] = '@'
    row
  end
end

class Gridgame
  def initialize(console = Console.new)
    @console = console
    @message = ''
    @rows = [DestinationRow.new, EmptyRow.new, PlayerRow.new]
  end

  def start
    do_display
    @console.input {|c|
      if c == 'r'
        check_moved(player_row.right)
      elsif c == 'l'
        check_moved(player_row.left)
      end
      do_display
    }
  end

  def check_moved(moved)
    @message = 'Cannot move there' unless moved
  end

  private

  def do_display
    @console.output @rows.map(&:to_s) + [@message]
  end

  def player_row
    @rows.last
  end
end