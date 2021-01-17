# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, sessions_controller, order_repository, orders_controller)
    @customers_controller = customers_controller
    @meals_controller = meals_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    puts "Welcome to Siq Restaurant!"
    puts "           --           "
    employee = @sessions_controller.sign_in
    while @running
      if employee.manager?
        # Print mgr menu
        display_manager_tasks
        action = gets.chomp.to_i
        print `clear`
        route_manager_action(action)
      else
        # Print delivery_guy menu
        display_delivery_guy_menu
        action = gets.chomp.to_i
        print `clear`
        route_delivery_guy_action(action)
      end
    end
  end

  private

  def display_delivery_guy_menu
    puts "1. Mark order as delivered"
    puts "2. List undelivered orders"
    puts "8. Exit"
    print "> "
  end

  def route_delivery_guy_action(action)
    case action
    when 1 then @orders_controller.mark_as_delivered(employee)
    when 2 then @orders_controller.list_undelivered_orders
    when 8 then stop
    else puts "Please choose an option"
    end
  end

  def route_manager_action(action)
    case action
    when 1 then @customers_controller.list
    when 2 then @customers_controller.add
    when 3 then @customers_controller.destroy
    when 4 then @meals_controller.list
    when 5 then @meals_controller.add
    when 6 then @meals_controller.destroy
    when 7 then @meals_controller.edit
    when 8 then stop
    else puts "Please choose an option"
    end
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all customers"
    puts "2 - Create a new customer"
    puts "3 - Destroy a customer"
    puts "4 - List all meals"
    puts "5 - Order a new meal"
    puts "6 - Destroy a meal"
    puts "7 - Edit a meal"
    puts "8 - Stop and exit the program"
  end

  def stop
    @running = false
  end
end
