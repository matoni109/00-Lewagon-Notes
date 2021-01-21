#
# https://guides.rubyonrails.org/active_record_basics.html
#
DB = SQLite3::Database.new("db/database.sqlite3")
DB.execute("INSERT INTO restaurants (name) VALUES ('La Tour d\'Argent')")

class Post
  def initialize(attributes = {})
    @title = attributes[:title]
  end
end

restaurant = Restaurant.new(name: "La Tour d'Argent")
restaurant.save

## Active record be like...

class Post < ActiveRecord::Base
end

## Alwasy pural

# config/database.yml
development:
  adapter: sqlite3                   # Database vendor (soon, postgres)
database: db/development.sqlite3   # File path of the database

rake db:create
ll db

rake db:drop
ll db

## Table Creation Migration ##
# make the migrations in the migrate dir

rake db:timestamp
=> timestamp
touch db/migrate/timestamp_create_restaurants.rb


TIMESTAMP=`rake db:timestamp`
touch db/migrate/${TIMESTAMP}_create_restaurants.rb

# db/migrate/**********_create_restaurants.rb
class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string    :name
      t.string    :address
      t.timestamps null = false # add 2 columns, `created_at` and `updated_at`
    end
  end
end

Run the migrations

rake db:create
rake db:migrate
# you can chain them also

Add a column migration

TIMESTAMP=`rake db:timestamp`
touch db/migrate/${TIMESTAMP}_add_rating_to_restaurants.rb

# db/migrate/********_add_rating_to_restaurants.rb
class AddRatingToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :rating, :integer, default: 0, null: false
  end
end

##
restaurant.rb#!/usr/bin/env ruby -wKU
# camel case and singular
# table is snake case pural
#
class Restaurant < ActiveRecord::Base[6.0]

end

dr_house = Doctor.new(name: "Greg House")
dr_house.save
# => INSERT INTO doctors (name) VALUES ('Greg House');

dr_house = Doctor.create(name: "Greg House")
# => INSERT INTO doctors (name) VALUES ('Greg House');


Restaurant.last
# returns the last restaurant in the DB (highest id).

Restaurant.find(2)
Doctor.count
# => returns the number of Doctor instances (Integer).

Restaurant.where("rating >= 4").order(rating: :asc).first(5)


Restaurant.find_by_name("the weak goose")
# table sport_cars
# => class SportsCar

# table => products
# class Product

# Create a restaurant
fox = Restaurant.new(name: "the fox")

# Read ()
restaurants = Restaurant.all
second_restaurant = Restaurant.find(2)
first_bristol = Restaurant.find_by_address("bristol")

# Update
fox.address = "bristol"
fox.save

# Delete
second_restaurant.destroy

# Advanced Queries
Restaurant.count
=> 2

Restaurant.first
=>

  fox.address = "london"
goose = Restaurant.last
goose.address = "brixton"

surgeons = Doctor.where(specialty: "Surgeon")
# => returns a collection (~ array) of all surgeons.

You can also pass a string as an argument to the .where class method:

  young_doctors = Doctor.where("age < 35")
# => returns a collection (~ array) of all doctors under 35 years old.

surgeons = Doctor.where("specialty LIKE %surgery%")
# => returns a collection (~ array) of all doctors with 'surgery' in their specialty.

And last:

  dentists_and_surgeons = Doctor.where(specialty: ["Dentist", "Surgeon"])


Resturant.create(name: "the white hart", address: "london")
Resturant.create(name: "the golden lion and the goose", address: "bristol")

Restaurant.all?

Restaurant.where(address: "London")
Restaurant.where("name LIKE ?", "%goose%")

Restaurant.order(address: :asc)
Restaurant.order(created_at: :desc)

## SEEDS ##

seeds.rb#!/usr/bin/env ruby -wKU
fox = Restaurant.new(name: "fox")
fox.save

lion = Restaurant.new(name: "lion")
lion.save

elephant = Restaurant.new(name: "elephant")
elephant.save

# rake db:creat db:migrate db:seed
#

#Person.pluck(:name)
# SELECT people.name FROM people
# => ['David', 'Jeremy', 'Jose']

Person.pluck(:id, :name)
# SELECT people.id, people.name FROM people
# => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]

Person.distinct.pluck(:role)
# SELECT DISTINCT role FROM people
# => ['admin', 'member', 'guest']

Person.where(age: 21).limit(5).pluck(:id)
# SELECT people.id FROM people WHERE people.age = 21 LIMIT 5
# => [2, 3]

Person.pluck('DATEDIFF(updated_at, created_at)')
# SELECT DATEDIFF(updated_at, created_at) FROM people
# => ['0', '27761', '173']

gem install faker

# db/seeds.rb
require 'faker'

puts 'Creating 100 fake restaurants...'
100.times do
  restaurant = Restaurant.new(
    name:    Faker::Company.name,
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    rating:  rand(0..5)
  )
  restaurant.save!
end
puts 'Finished!'

# Scrape STuff ###
#
#

require "json"
require "rest-client"

response = RestClient.get "https://api.github.com/users/lewagon/repos"
repos = JSON.parse(response)
# => repos is an `Array` of `Hashes`.

repos.size
# => 30
