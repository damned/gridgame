class Row
  def initialize(row_size)
    @row_size = row_size
    @actors = []
  end

  def remove(actor)
    @actors.delete actor
  end

  def add(actor)
    @actors << actor
  end

  def to_s
    row = '.' * @row_size
    @actors.each { |actor|
      row[actor.x] = actor.to_s
    }
    row
  end
end