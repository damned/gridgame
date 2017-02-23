require_relative 'actor'

class Player < Actor
  def to_s
    '@'
  end

  def player?
    true
  end
end
