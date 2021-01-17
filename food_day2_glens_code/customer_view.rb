class CustomerView
  def customer_name
    puts 'What is your name?'
    print '> '
    gets.chomp
  end

  def customer_address
    puts 'What is your address?'
    print '> '
    gets.chomp
  end

  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - Name: #{customer.name}\nAddress: #{customer.address}"
    end
  end

  def ask_for_index
    puts "Which index?"
    print "> "
    return gets.chomp.to_i - 1
  end
end
