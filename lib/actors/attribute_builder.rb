require_relative 'static_actor'

class AttributeBuilder < StaticActor
  def initialize(position)
    @attribute = :experience
    @last_here = [ self ]
    super position
  end

  def move_here_ok?(mover)
    true
  end

  def post_tick(area)
    generate_moved_here_events area
  end

  def to_c
    '+'
  end

  private

  def generate_moved_here_events(area)
    actors_here = area.whats_at(@position)
    actors_here.reject { |actor|
      @last_here.include? actor
    }.each { |actor|
      moved_here actor
    }
    @last_here = actors_here
  end

  def moved_here(actor)
    actor.increase_attribute @attribute, 20
  end
end