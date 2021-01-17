require 'csv'
require 'pry-byebug'
require_relative '../models/meal'

class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = @elements.length + 1
    populate_master if File.exist?(@csv_file_path)
  end

  def create(element)
    element.id = @next_id
    @next_id += 1
    @elements << element
    save_csv
  end

  def all
    @elements
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  def remove(index)
    @elements.delete_at(index)
    save_csv
  end

  def edit_name(index, new_name)
    @elements[index].name = new_name
    save_csv
  end

  def edit_price(index, new_price)
    @elements[index].price = new_price
    save_csv
  end

  def save_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.open(@csv_file_path, 'wb', **csv_options) do |csv|
      csv << @elements[0].headers
      @elements.each do |element|
        csv << element.to_ary
      end
    end
  end
end
