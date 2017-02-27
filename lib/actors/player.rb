require_relative 'actor'
require_relative '../attributes'

class Player < Actor
  def initialize(position)
    @attributes = { experience: Attributes::Experience.new }
    super position
  end

  def tick(area)
    @attributes.values.each {|a| a.tick area }
  end

  def increase_attribute(key, amount)
    attributes[key].increase_by 20
  end

  def to_s
    '@'
  end

  def player?
    true
  end

  def status
    @attributes.values.map(&:to_s).join ' '
  end

  private

  attr_reader :attributes

end
