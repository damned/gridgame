require_relative 'console'

class Gridgame
  def initialize(console = Console.new)
    @console = console
  end

  def start
    @console.output ['.....', '.....', '@....']
    @console.input {
      @console.output ['.....', '.....', '.@...']
    }
  end
end