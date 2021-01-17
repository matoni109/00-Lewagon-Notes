require_relative '../views/customer_view'
require_relative '../views/meal_view'
require_relative '../views/employee_view'
require_relative '../views/order_view'
require_relative 'customers_controller'
require_relative 'meals_controller'
require 'pry-byebug'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @meal_repository = meal_repository
    @order_repository = order_repository
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
    @order_view = OrderView.new
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @order_view.show_undelivered(undelivered_orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select do |order|
      order.employee == employee
    end
    @order_view.show_undelivered(orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_index = @order_view.ask_for_index
    orders = @order_repository.undelivered_orders.select do |order|
      order.employee == employee
    end
    order = orders[order_index]
    @order_repository.mark_as_delivered(order)
  end

  # Create a new Order
  def add
    display_meals
    meal_index = @meal_view.ask_for_index
    meal = @meal_repository.all[meal_index]

    display_customers
    customer_index = @customer_view.ask_for_index
    customer = @customer_repository.all[customer_index]

    display_employees
    employee_index = @employee_view.ask_for_index
    employee = @employee_repository.all_delivery_guys[employee_index]

    # Create a new instance of Order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end

  private

  def display_meals
    meals = @meal_repository.all
    @meal_view.display(meals)
  end

  def display_customers
    customers = @customer_repository.all
    @customer_view.display(customers)
  end

  def display_employees
    employees = @employee_repository.all_delivery_guys
    @employee_view.display(employees)
  end
end
