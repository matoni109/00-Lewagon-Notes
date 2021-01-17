def list(gifts_array)
  gifts_array.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift[:purchased] ? "[X]" : "[ ]" } #{gift[:gift_name]} "
  end
end

def add_gift(gifts_array)
  # Add a user message
  puts "What would you like to add to your Christmas List"
  # Get answer from the user
  gift_name = gets.chomp
  # Add the answer into the gift_array
  gifts_array << {gift_name: gift_name, purchased: false }
  list(gifts_array)
end

# DEBUG
def delete(my_gift_list)
  # Display all our items
  list(my_gift_list)
  # Ask user which item to delete
  puts "> What would you like to delete - select an item number"
  # Get user input
  index = gets.chomp.to_i - 1
  # Remove item from the array
  my_gift_list.delete_at(index)
  list(my_gift_list) #ERROR COME FROM THE VARIABLE NAME BEING gifts_array and not my_gift_list
end

def mark_as_purchased(gifts_array)
  # list all the items...
  list(gifts_array)
  # Select item to mark as purchased
  puts "> What would you like to update - select an item number"
  # Get user input
  index = gets.chomp.to_i - 1
  # Select item to mark
  gifts_array[index][:purchased] = true
  # Change the value of purchased
  list(gifts_array)
end
