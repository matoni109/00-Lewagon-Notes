class Meal
  attr_accessor :id, :name, :price

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  def to_ary
    [id, name, price]
  end

  def headers
    ["id", "name", "price"]
  end
end
