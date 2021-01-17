class EmployeeView
  def ask_for_index
    puts "Which index?"
    print "> "
    return gets.chomp.to_i - 1
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - Name: #{employee.username}"
    end
  end
end
