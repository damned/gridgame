require_relative 'static_actor'

class CharmingChain < StaticActor
  def to_c
    'c'
  end

  def takeable?
    true
  end

  def to_s
    'charming chain'
  end
end