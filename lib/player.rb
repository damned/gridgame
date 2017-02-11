class Player
  MIN_X = 0
  MAX_X = 4
  MIN_Y = 0
  MAX_Y = 2

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
    true
  end
  def up
    return false if @y == MIN_Y
    @y -= 1
    true
  end
  def down
    return false if @y == MAX_Y
    @y += 1
    true
  end
  def to_s
    '@'
  end
end
