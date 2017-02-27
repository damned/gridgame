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
        actor = @actors.find {|a| a.x == x && a.y == y }
        actor.nil? ? '.' : actor.to_c
      }.join('')
    }
  end

  def ok?(pos, actor)
    x_ok?(pos.x) && y_ok?(pos.y) && whats_at(pos).all?{|actor_here| actor_here.move_here_ok?(actor)}
  end

  def take_all(position)
    objects = whats_at(position).select(&:takeable?)
    objects.each {|o|
      @actors.delete o
    }
    objects
  end

  def whats_at(position)
    @actors.select {|actor|
      actor.position == position
    }
  end

  private

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