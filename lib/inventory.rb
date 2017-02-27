class Inventory
  def initialize
    @objects = []
  end

  def add_all(objects)
    @objects += objects
  end

  def to_s
    return '-' if @objects.empty?
    inventory_s = @objects.map(&:to_s).join ", "
  end
end