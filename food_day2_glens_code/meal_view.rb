class MealView
  def meal_name
    puts 'What is the name of the meal?'
    print '> '
    gets.chomp
  end

  def meal_price
    puts 'What is the price? ($)'
    print '> '
    gets.chomp.to_i
  end

  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - Name: #{meal.name}\nPrice: $#{meal.price}"
    end
  end

  def ask_for_index
    puts "Which index?"
    print "> "
    return gets.chomp.to_i - 1
  end

  def name_or_price
    puts "Edit 'name' or 'price'?"
    print "> "
    return gets.chomp
  end
end
