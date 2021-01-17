
# Classes and Instances

# gem install pry-byebug

require "pry-byebug"

binding.pry # => gives a break point

# freeze
# next = only nexxt line
# continue = goes to the next break point or end
#
#
# String

# Everything in ruby is an object.
# OOP is about data (or state) and behavior.
# State is stored in instance variables (@foo)
# Behavior is defined by instance methods (def bar in class definition)

name = String.new("John Lennon")  # (same as) name = "John Lennon"
name.split # => [ "John", "Lennon" ]

# Data (or State) = the list of characters.
# Behavior = the set of methods which can act on the list of characters.

# Class = mold
# Instance is a cake make of the Class mold
#
# you can use load "file.rb" # lower_snake_case
class Dog
  def initialize(name, breed)
    @name = name
    @breed = breed
  end
end

rex = Dog.new("Rex", "German Sheperd")
# => #<Dog:0x007f9423a86f10 @name="Rex" @breed="German Sheperd">

class Car
  # initialize is called by 'new'
  def initialize(color, brand) # constructor # persistance
    @color = color # String
    @engine_started = false# boolean
    @brand = brand
  end

  # start is an *instance* method inside class Car
  def start
    @engine_started = true
  end

  def engine_started? # method with boolean
    return @engine_started
  end

  attr_reader :color, :engine_started
  # or
  # def color
  #   return @color
  # end
  attr_writer :color

  # read / write
  attr_accessor :color

  # can not call private methods from outside !
  private

  def start_fuel_pump
  end

  def init_spark_plug
  end

end
Car.new
# => "You ran Car.new!"
Car.start # not valid
# .start must be called on an isntance

blue_car = Car.new("blue", "mazda")
blue_car.start
# => true changes @engine_started


red_car = Car.new("red", "porchse")
# Call the instance method 'start on theinstance 'red_car'
red_car.start
# red car is started


puts "is my car stared ? "
puts red_car.engine_started? ? "yes" : "no"
# yes

puts "What color is the car? "
puts red_car.color
# red

# Encapsulation
# create objects that hold info
# by default. state is hidden
# by default, instance variables are hidden
#     -> you need 'attr_reader' to expose them
#

# TODO: paint the car
my_car.color = "black"
# stop 2 1:06:00
