class Player
  attr_reader :x, :y
  def initialize(position)
    @x = position.x
    @y = position.y
  end
  def left(context)
    move_horizontal context, -1
  end
  def right(context)
    move_horizontal context, 1
  end
  def up(context)
    move_vertical context, -1
  end
  def down(context)
    move_vertical context, 1
  end
  def to_s
    '@'
  end

  private

  def move_horizontal(context, dx)
    newx = @x + dx
    return false unless context.x_ok?(newx)
    @x = newx
    true
  end

  def move_vertical(context, dy)
    newy = @y + dy
    return false unless context.y_ok?(newy)
    @y = newy
    true
  end

end
