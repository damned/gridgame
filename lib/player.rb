class Player
  MIN_X = 0
  MAX_X = 4

  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
  def left
    return false if @x == MIN_X
    @x -= 1
    true
  end
  def right
    return false if @x == MAX_X
    @x += 1
  end
  def up
    @y -= 1
  end
  def to_s
    '@'
  end
end
