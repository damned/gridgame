module Attributes
  class Experience
    def initialize
      @xp = 0
    end

    def tick(area)
      @xp += 1
    end

    def increase_by(amount)
      @xp += amount
    end

    def to_s
      "#{@xp}XP"
    end
  end
end