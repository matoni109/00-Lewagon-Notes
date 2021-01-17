require_relative 'meal'
require_relative 'customer'
require_relative 'employee'

class Order
  attr_accessor :id
  attr_reader :meal, :employee, :customer, :delivered

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  # def to_ary
  #   [id, delivered, meal.id, customer.id, employee.id]
  # end

  # def headers
  #   ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
  # end
end
