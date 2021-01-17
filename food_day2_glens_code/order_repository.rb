require 'csv'
require 'pry-byebug'
require_relative '../models/order'

CSV_OPTIONS = { headers: :first_row, header_converters: :symbol }

class OrderRepository
  def initialize(csv_file_path, meal, customer, employee)
    @csv_file_path = csv_file_path
    @meal_repository = meal
    @customer_repository = customer
    @employee_repository = employee
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, CSV_OPTIONS) do |row|
      attributes = {
        id: row[:id].to_i,
        delivered: row[:delivered] == 'true',
        meal: @meal_repository.find(row[:meal_id].to_i),
        customer: @customer_repository.find(row[:customer_id].to_i),
        employee: @employee_repository.find(row[:employee_id].to_i)
      }
      @orders << Order.new(attributes)
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |element|
        csv << [element.id, element.delivered, element.meal.id, element.customer.id, element.employee.id]
      end
    end
  end
end
