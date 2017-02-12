class GameArea
  def initialize(row_size, row_count)
    @row_size = row_size
    @row_count = row_count
    @rows = (1..row_count).map { Row.new(row_size) }
  end

  def add(actor)
    rows[actor.y].add actor
  end

  def rows
    @rows
  end

  def x_ok?(x)
    x >= 0 && x < @row_size
  end

  def y_ok?(y)
    y >= 0 && y < @row_count
  end

  def right(actor)
    actor.right self
  end

  def left(actor)
    actor.left self
  end

  def up(actor)
    @rows[actor.y].remove(actor)
    result = actor.up self
    @rows[actor.y].add(actor)
    result
  end

  def down(actor)
    @rows[actor.y].remove(actor)
    result = actor.down self
    @rows[actor.y].add(actor)
    result
  end
end