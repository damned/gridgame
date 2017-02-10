class Gridgame
  def initialize(console)
    @console = console
  end

  def start
    @console.update ['.....', '.....', '.....']
  end
end