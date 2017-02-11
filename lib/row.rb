class Row
  def initialize(*actors)
    @actors = actors
  end

  def remove(actor)
    @actors.delete actor
  end

  def add(actor)
    @actors << actor
  end

  def to_s
    row = '.....'
    @actors.each { |actor|
      row[actor.x] = actor.to_s
    }
    row
  end
end