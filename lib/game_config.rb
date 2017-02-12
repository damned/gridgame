
class Position
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

class GameConfig
  attr_reader :width, :height, :positions

  def initialize
    @positions = {}
    with_player_at 0, 2
    with_destination_at 3, 0
    with_size 5, 3
  end

  def with_size(w, h)
    @width = w
    @height = h
    self
  end

  def with_actor_at(x, y)
    place :actor, x, y
  end

  def with_player_at(x, y)
    place :player, x, y
  end

  def with_destination_at(x, y)
    place :destination, x, y
  end

  private

  def place(key, x, y)
    @positions[key] = Position.new(x, y)
    self
  end
end