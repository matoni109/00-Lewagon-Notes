require 'csv'
require_relative '../models/customer'
require_relative 'base_repository'

class CustomerRepository < BaseRepository
  def initialize(csv_file_path)
    super
    @csv_file_path = csv_file_path
  end

  def populate_master
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << Customer.new(row)
      @next_id = row[:id] + 1
    end
  end
end
