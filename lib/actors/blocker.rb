require_relative 'static_actor'

class Blocker < StaticActor
  def move_here_ok?(mover)
    false
  end

  def to_c
    'B'
  end
end