class Actor
  def initialize(position)
    @position = position
  end
  def x
    @position.x
  end
  def y
    @position.y
  end
  def to_s
    'a'
  end
end

class Destination < Actor
  def to_s
    'X'
  end
end
