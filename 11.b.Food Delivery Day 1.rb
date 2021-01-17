

#
# Glens Code => https://gist.github.com/glenntippett/2889c9f5a861dbdabaf875d7c295524c
#employee.#!/usr/bin/env ruby -wKU
class Employee
  attr_reader :username, :password

  def initialize(attributes = {})
    # ID,username, password, role
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role] # manager / delivery guy
  end

end


## employees_repo.rb
require_relative "base_repository"

class EmployeeRepository < Base_Repository

  # should we do this ??
  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end

  def manager?
    @role == "manager" # take role from CSV ??
  end

end

# ### employee_view.rb
# #
# class EmployeeView

#   def ask_for(label)
#     puts "What is the customer's #{label}?"
#     gets.chomp
#   end

# end


## Sessions controler
# sessions_controller.rb
#
require_relative "../views/sesions_view"
class SessionController

  def initialize
    @view = SessionsView.new
    @employee_repository = employee_repository
  end

  def sign_in
    # ask user for username
    username = @view.ask_for(:username)
    # ask user for password
    password = @view.ask_for(:password)
    # find the employee with the username
    employee = @employee_repository.find_by_username(username)
    # compare the password with the database
    if employee && employee.password == password
      #Logged In
      @view.logged_in(employee)
      return employee # return the employees creds
    else
      @view.wrong_credentials
      # try again
      sign_in # Recursive call
    end
  end

end

### sessions_view.rb
#
class SessionView

  def ask_for(label)
    puts "What is the customer's #{label}?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials... try again"
    puts ">"
  end

  def logged_in(employee)
    if employee.manager?
      puts "[MANAGER] welcome #{employee.username}!"
    else
      puts " [DELIVERY GUY ] welcome #{employee}!"
    end
  end
end

############# ROUTER BELOW FROM DAY 1 ################3
class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller.rb = sessions_controller
    @running = true
  end

  def run

    loop do
      puts "Welcome to the food delivery app!"
      puts "           --           "
      # => make a login || login page
      @sessions_controller.sign_in

      while @running
        if employee.manager?
          print_manager_menu
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          print delivery guy mend
        end
      end
      print `clear`
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then
    when 6 then stop
    when 9 then
    else
      puts "Please press 1, 2, 3, 4, 5 or 6"
    end
  end

  def route_delivery_guy_action(action)
    case action
    when 1 then TODO list my orders
    when 2 then TODO mark an order del
    when 3 then stop
    else
      puts "Please press 1, 2, 3"
    end
  end

  def stop
    @running = false
  end

  def print_manager_menu
    puts ""
    puts "What do you want to do next?"
    puts "1 - Order a meal"
    puts "2 - List all meals"
    puts "3 - Add a customer"
    puts "4 - List all customers"
    puts "5 - Stop and exit the program"
    print ">"
  end

  def print_delivery_guy_menu
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Mark as delivered"
    puts "5 - Stop and exit the program"
    print ">"
  end

end
######## end router day 1 #######

############ app day 1 below #######

#   ruby app.rb
require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/repositories/meal_repository'
require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'router'

CSV_FILE = File.join(File.dirname(__FILE__), 'data/meals.csv')
meal_repo = MealRepository.new(CSV_FILE)
meals_controller = MealsController.new(meal_repo)

CSV_FILE2 = File.join(File.dirname(__FILE__), 'data/customers.csv')
customers_repo = CustomerRepository.new(CSV_FILE2)
customers_controller = CustomersController.new(customers_repo)

CSV_FILE3 = File.join(File.dirname(__FILE__), 'data/meals.csv')
employee_repository = Employee.new(CSV_FILE3)
sessions_controller = SessionsController.new(employee_repository)

router = Router.new(meals_controller, customers_controller)

# Start the app
router.run

############ app day 1 END  #######
