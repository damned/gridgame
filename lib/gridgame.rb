require_relative 'console'

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
    last_row = PlayerRow.new
    do_display(last_row.to_s)
    @console.input {|c|
      if c == 'r'
        last_row.right
        do_display(last_row.to_s)
      end
    }
  end

  def do_display(last_row)
    @console.output ['.....', '.....', last_row]
  end
end