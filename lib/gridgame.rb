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
  end

  def start
    rows = [DestinationRow.new, EmptyRow.new, PlayerRow.new]
    do_display(rows)
    @console.input {|c|
      if c == 'r'
        rows.last.right
        do_display(rows)
      end
    }
  end

  def do_display(rows)
    @console.output rows.map(&:to_s)
  end
end