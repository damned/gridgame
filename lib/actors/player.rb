require_relative 'actor'
require_relative '../attributes'

class Player < Actor
  def initialize(position)
    @attributes = [ Attributes::Experience.new ]
    super position
  end

  def tick(area)
    @attributes.each {|a| a.tick area }
  end

  def to_s
    '@'
  end

  def player?
    true
  end

  def status
    @attributes.map(&:to_s).join ' '
  end
end
