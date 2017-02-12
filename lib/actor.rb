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

  def player?
    false
  end

  def tick(area)
    area.right(self)
  end

  def to_s
    'a'
  end

  def left(area)
    move area, -1, 0
  end
  def right(area)
    move area, 1, 0
  end
  def up(area)
    move area, 0, -1
  end
  def down(area)
    move area, 0, 1
  end

  private

  def move(area, dx, dy)
    newpos = Position.new(@position.x + dx, @position.y + dy)
    return false unless area.ok?(newpos)
    @position = newpos
    true
  end

end