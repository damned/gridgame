class GameArea
  def initialize(row_count)
    @rows = (1..3).map { Row.new }
  end

  def add(actor)
    rows[actor.y].add actor
  end

  def rows
    @rows
  end

  def right(actor)
    actor.right
  end

  def left(actor)
    actor.left
  end

  def up(actor)
    @rows[actor.y].remove(actor)
    result = actor.up
    @rows[actor.y].add(actor)
    result
  end

  def down(actor)
    @rows[actor.y].remove(actor)
    result = actor.down
    @rows[actor.y].add(actor)
    result
  end
end