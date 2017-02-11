require_relative 'console'

class Gridgame
  def initialize(console = Console.new)
    @console = console
  end

  def start
    do_display('@....')
    @console.input {|c|
      do_display('.@...') if c == 'r'
    }
  end

  def do_display(last_row)
    @console.output ['.....', '.....', last_row]
  end
end