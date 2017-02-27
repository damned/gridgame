class Actor
  attr_reader :position

  Directions = %i(right down left up)
  def initialize(position)
    @position = position
    @direction_index = 0
  end

  def x
    @position.x
  end

  def y
    @position.y
  end

  def at?(pos)
    @position == pos
  end

  def move_here_ok?(mover)
    true
  end

  def player?
    false
  end

  def whats_here_in(game_area)
    game_area.whats_at(position).reject {|thing|
      thing == self
    }
  end

  def tick(area)
    direction = Directions[@direction_index]
    until area.send(direction, self) do
      @direction_index = (@direction_index + 1) % 4
      direction = Directions[@direction_index]
    end
  end

  def post_tick(area)
    #NOP
  end

  def takeable?
    false
  end

  def to_s
    to_c
  end

  def to_c
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
    return false unless area.ok?(newpos, self)
    @position = newpos
    true
  end

end