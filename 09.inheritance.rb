#
# Inheritance, class methods, self

puts "The restaurant is now #{fifteen.open? ? "open": "closed"}"
require_relative "chef"

class Restaurant

  attr_reader :chef, :city, :name # no capacity =>
  attr_writer :capacity

  def initialize (name, city, capacity, category, chef_name)
    #state
    #ivar
    @name = name
    @city = cityRestaurant
    @capacity = capacity
    @category = category

    unless chef_name.nil?             # store yourself in a different instance
      @chef = Chef.new(chef_name, self) # chef takes the resturant instance
    end     # self is referring to the instnace on which it is called .

    @clients = []
  end

  def self.categories # l ike Restaurant.categories
    ["french", "italian"]
  end

  def book(client_name)
    @clients << client_name
  end

  def open?
    if Time.now.hour >= 18 && Time.now.hour <= 22
      return true
    else
      return false
    end
  end

  def capacity
    if Time.now.hour >= 19
      @capacity +20 #terrace is open
    else
      @capacity
    end
  end

end

## Chef Class # links to restaurant
require_relative "restaurant"

class Chef

  attr_reader :name, :restaurant

  def initialize(name)
    @name = name # String
    @restaurant = restaurant # restaurant
  end
end

require_relative 'restaurant'




#example 1
fifteen =
  Restaurant.new("fifteen", "london", 50, "british_modern", "Jamie Oliver")
fifteen.name # name is a instance method

puts "the Chef of #{fifteen.name} is #{fifteen.chef.name}"
#example 2
jamie = fifteen.chef #instance of chef
puts = jamie.class # instance of Restaurant
#


# example 2
class  Building
  attr_reader :name, :width, :length

  def initialize(name, width, length)
    @name = name
    @width, @length = width, length
  end

  def floor_area
    @width * @length
  end
end


# you can use
def initialize
  super() # to call the method from the Parent
  # you can take away the reader and give the instance
  # and do a if statement.
  # child ivars
  @child_ivars
end

require_relative 'Building'

class House < Building
  attr_reader :name, :width, :length
  def initialize(name, width, length)
    @name = name
    @width, @length = width, length
  end

  def floor_area
    @width * @length
  end
end

class Castle
  attr_reader :name, :width, :length
  def initialize(name, width, length)
    @name = name
    @width, @length = width, length
  end

  def floor_area
    @width * @length
  end
end


###
#self
Time.now # class method
require "json"
JSON.parse("{}") # parse is a class method of JSON

require_relative "restaurant"
fifteen =
  Restaurant.new("fifteen", "london", 50, "british_modern")
fifteen.name # name is a instance method

def self.categories
  [ "french", "italian"]
end

Restaurant.categories # categories is a class method

# you can't call class method on an istance

# use a class method when
# You create a class method if it does not need/is
# => not relevant to a single instance

# dont us a class method if you don't know

# JSON.parse('{ "key": "value", "other_key": "other_value" }')
#   parse is a class method of JSON which returns an instance of Hash.

# Self Example with inherited method

class Mother
  @subclass = []
  def self.inherited(child_class)
    @subclass << child_class
  end

  def self.phone_kids
    @subclass.each{|x| x.phone }
  end

end
