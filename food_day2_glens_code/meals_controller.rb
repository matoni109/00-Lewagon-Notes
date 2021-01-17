require_relative '../views/meal_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def add
    # Get name and  description of recipe
    meal_name = @view.meal_name
    meal_price = @view.meal_price
    # Create new Meal
    meal = Meal.new(name: meal_name, price: meal_price)
    # Add to Meals repo
    @meal_repository.create(meal)
  end

  def list
    display_meals
  end

  def destroy
    display_meals
    index = @view.ask_for_index
    @meal_repository.remove(index)
    puts "Meals now includes: "
    display_meals
  end

  def edit
    display_meals
    index = @view.ask_for_index
    to_edit = @view.name_or_price
    edit_case(to_edit, index)
  end

  def edit_case(to_edit, index)
    case to_edit
    when 'name'
      new_name = @view.meal_name
      @meal_repository.edit_name(index, new_name)
    when 'price'
      new_price = @view.meal_price
      @meal_repository.edit_price(index, new_price)
    else puts "Please enter 'name' or 'price'"
    end
  end

  private

  def display_meals
    # 1. Fetch meals from repo
    meals = @meal_repository.all
    # 2. Send them to view for display
    @view.display(meals)
  end
end
