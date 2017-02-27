require_relative 'actor'
require_relative '../attributes'
require_relative '../inventory'

class Player < Actor
  def initialize(position)
    @attributes = { experience: Attributes::Experience.new }
    @inventory = Inventory.new
    super position
  end

  def tick(area)
    @attributes.values.each {|a| a.tick area }
  end

  def take(area)
    inventory.add_all area.take_all(position)
  end

  def increase_attribute(key, amount)
    attributes[key].increase_by 20
  end

  def to_c
    '@'
  end

  def to_s
    'Player'
  end

  def player?
    true
  end

  def status
    [ attributes_status, inventory.to_s ].join ' Carrying: '
  end

  private

  attr_reader :attributes, :inventory

  def attributes_status
    @attributes.values.map(&:to_s).join ' '
  end

end
