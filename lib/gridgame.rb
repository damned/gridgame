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
  def initialize
    @player_x = 0
  end
  def left
    @player_x -= 1
  end
  def right
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
        player_row.right
      elsif c == 'l'
        player_row.left
      end
      do_display
    }
  end

  private

  def do_display
    @console.output @rows.map(&:to_s) + [@message]
  end

  def player_row
    @rows.last
  end
end