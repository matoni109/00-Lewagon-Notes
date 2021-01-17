require_relative '../views/customer_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def add
    # Get name and  description of recipe
    customer_name = @view.customer_name
    customer_address = @view.customer_address
    # Create new customer
    customer = Customer.new(name: customer_name, address: customer_address)
    # Add to customers repo
    @customer_repository.create(customer)
  end

  def list
    display_customers
  end

  def destroy
    display_customers
    index = @view.ask_for_index
    @customer_repository.remove(index)
    puts "Customer now includes: "
    display_customers
  end

  private

  def display_customers
    # 1. Fetch customers from repo
    customers = @customer_repository.all
    # 2. Send them to view for display
    @view.display(customers)
  end
end
