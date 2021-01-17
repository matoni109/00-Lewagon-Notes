require 'pry-byebug'

class OrderView
  def ask_for_index
    puts "Which index?"
    print "> "
    return gets.chomp.to_i - 1
  end

  # def ask_for(label)

  # end

  def show_undelivered(arr_of_undelivered_orders)
    arr_of_undelivered_orders.each_with_index do |order, index|
      status = order.delivered? ? '[X]' : '[ ]'
      puts "#{index + 1} - #{status} #{order.meal.name} for #{order.customer.name} | Delivered by: #{order.employee.username}"
    end
  end
end
