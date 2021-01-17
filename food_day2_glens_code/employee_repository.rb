require 'csv'
require 'pry-byebug'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    populate_elements if File.exist?(@csv_file_path)
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  def all_delivery_guys
    @elements.select { |element| element.delivery_guy? }
  end

  def find_by_username(username)
    @elements.find { |element| element.username == username }
  end

  private

  def populate_elements
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << Employee.new(row)
      @next_id = row[:id] + 1
    end
  end
end
