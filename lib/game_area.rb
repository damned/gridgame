class GameArea
  def initialize(row_size, row_count)
    @row_size = row_size
    @row_count = row_count
    @actors = []
  end

  def add(actor)
    @actors << actor
  end

  def rows
    @rows
  end

  def right(actor)
    actor.right self
  end

  def left(actor)
    actor.left self
  end

  def up(actor)
    actor.up self
  end

  def down(actor)
    actor.down self
  end

  def to_a
    row_indices.map {|y|
      column_indices.map {|x|
        actor = @actors.find {|actor| actor.x == x && actor.y ==y }
        actor.nil? ? '.' : actor.to_s
      }.join('')
    }
  end

  def ok?(pos, actor)
    x_ok?(pos.x) && y_ok?(pos.y) && actors_at(pos).all?{|actor_here| actor_here.move_here_ok?(actor)}
  end

  private

  def actors_at(pos)
    @actors.select {|actor|
      actor.at?(pos)
    }
  end

  def column_indices
    (0..(@row_size - 1))
  end

  def row_indices
    (0..(@row_count - 1))
  end

  def x_ok?(x)
    x >= 0 && x < @row_size
  end

  def y_ok?(y)
    y >= 0 && y < @row_count
  end


end