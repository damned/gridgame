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
  def to_s
    '@'
  end
end
