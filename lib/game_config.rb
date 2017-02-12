class GameConfig
  attr_reader :width, :height

  def initialize
    with_size 5, 3
  end

  def with_size(w, h)
    @width = w
    @height = h
    self
  end
end