##
#
#


rails new restaurant-reviews
cd restaurant-reviews

# In the terminal
yarn add bootstrap

rm app/assets/stylesheets/application.css
touch app/assets/stylesheets/application.scss
stt

/* application.scss */
@import "bootstrap/scss/bootstrap"; /* picks it up in node_modules! */

<!-- application.html.erb -->
<head>
<!-- ... -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>

##

gem 'simple_form'

Then, run:

  bundle install
rails generate simple_form:install --bootstrap

# db/seeds.rb
puts "Cleaning database..."
Restaurant.destroy_all

puts "Creating restaurants..."
dishoom = { name: "Dishoom", address: "7 Boundary St, London E2 7JE", stars: 5 }
pizza_east =  { name: "Pizza East", address: "56A Shoreditch High St, London E1 6PQ", stars: 4 }

[ dishoom, pizza_east ].each do |attributes|
  restaurant = Restaurant.create!(attributes)
  puts "Created #{restaurant.name}"
end
puts "Finished!"




Beyond CRUD
Simple form

gem 'simple_form'

Then, run:

  bundle install
rails generate simple_form:install --bootstrap

First commit

git add .
  git commit -m "Rails new with frontend and form gems"

7 Actions

# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants
end

Prefix  Verb    URI Pattern            Controller#Action
restaurants  GET     /restaurants           restaurants#index
POST    /restaurants           restaurants#create
new_restaurant  GET     /restaurants/new       restaurants#new
edit_restaurant  GET     /restaurants/:id/edit  restaurants#edit
restaurant  GET     /restaurants/:id       restaurants#show
PATCH   /restaurants/:id       restaurants#update
DELETE  /restaurants/:id       restaurants#destroy

Scaffold

Only for demos not for projects
You never need all of the 7 CRUD actions in real projects

# gem 'jbuilder' comment this line

bundle install
rails g scaffold Restaurant name address stars:integer
rails db:migrate

git add .
  git commit -m "scaffold restaurants"

Seed

# db/seeds.rb
puts "Cleaning database..."
Restaurant.destroy_all

puts "Creating restaurants..."
dishoom = { name: "Dishoom", address: "7 Boundary St, London E2 7JE", stars: 5 }
pizza_east =  { name: "Pizza East", address: "56A Shoreditch High St, London E1 6PQ", stars: 4 }

[ dishoom, pizza_east ].each do |attributes|
  restaurant = Restaurant.create!(attributes)
  puts "Created #{restaurant.name}"
end
puts "Finished!"


# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants do
    collection do
      get :top
    end
  end
end

rails routes | grep top
# Prefix           Verb URI Pattern                 Controller#Action
# top_restaurants  GET  /restaurants/top(.:format)  restaurants#top

# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  def top
    @restaurants = Restaurant.where(stars: 5)
  end
end

rails generate migration AddChefNameToRestaurants chef_name:string
rails db:migrate

Rails.application.routes.draw do
  resources :restaurants do
    member do
      get :chef
    end
  end
end


Beyond CRUD
Simple form

gem 'simple_form'

Then, run:

  bundle install
rails generate simple_form:install --bootstrap

First commit

git add .
  git commit -m "Rails new with frontend and form gems"

7 Actions

# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants
end

Prefix  Verb    URI Pattern            Controller#Action
restaurants  GET     /restaurants           restaurants#index
POST    /restaurants           restaurants#create
new_restaurant  GET     /restaurants/new       restaurants#new
edit_restaurant  GET     /restaurants/:id/edit  restaurants#edit
restaurant  GET     /restaurants/:id       restaurants#show
PATCH   /restaurants/:id       restaurants#update
DELETE  /restaurants/:id       restaurants#destroy

Scaffold

Only for demos not for projects
You never need all of the 7 CRUD actions in real projects

# gem 'jbuilder' comment this line

bundle install
rails g scaffold Restaurant name address stars:integer
rails db:migrate

git add .
  git commit -m "scaffold restaurants"

Seed

# db/seeds.rb
puts "Cleaning database..."
Restaurant.destroy_all

puts "Creating restaurants..."
dishoom = { name: "Dishoom", address: "7 Boundary St, London E2 7JE", stars: 5 }
pizza_east =  { name: "Pizza East", address: "56A Shoreditch High St, London E1 6PQ", stars: 4 }

[ dishoom, pizza_east ].each do |attributes|
  restaurant = Restaurant.create!(attributes)
  puts "Created #{restaurant.name}"
end
puts "Finished!"

rails db:seed

Controller

# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  def top
    @restaurants = Restaurant.where(stars: 5)
  end
end

About the chef

Now we want a route to display info about the chef of a restaurant.

  GET /restaurants/42/chef

rails generate migration AddChefNameToRestaurants chef_name:string
rails db:migrate

Member

# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants do
    member do
      get :chef
    end
  end
end

rails routes | grep chef
# Prefix           Verb URI Pattern                      Controller#Action
# chef_restaurant  GET  /restaurants/:id/chef(.:format)  restaurants#chef

Controller

# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [ :chef ]

  def chef
    @chef_name = @restaurant.chef_name
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end


Beyond CRUD
Quick setup

rails new restaurant-reviews
cd restaurant-reviews

Bootstrap

# In the terminal
yarn add bootstrap

rm app/assets/stylesheets/application.css
touch app/assets/stylesheets/application.scss
stt

/* application.scss */
@import "bootstrap/scss/bootstrap"; /* picks it up in node_modules! */

<!-- application.html.erb -->
<head>
<!-- ... -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>

Simple form

gem 'simple_form'

Then, run:

  bundle install
rails generate simple_form:install --bootstrap

First commit

git add .
  git commit -m "Rails new with frontend and form gems"

Scaffold

Only for demos not for projects
You never need all of the 7 CRUD actions in real projects

# gem 'jbuilder' comment this line

bundle install
rails g scaffold Restaurant name address stars:integer
rails db:migrate

git add .
  git commit -m "scaffold restaurants"

Seed

# db/seeds.rb
puts "Cleaning database..."
Restaurant.destroy_all

puts "Creating restaurants..."
dishoom = { name: "Dishoom", address: "7 Boundary St, London E2 7JE", stars: 5 }
pizza_east =  { name: "Pizza East", address: "56A Shoreditch High St, London E1 6PQ", stars: 4 }

[ dishoom, pizza_east ].each do |attributes|
  restaurant = Restaurant.create!(attributes)
  puts "Created #{restaurant.name}"
end
puts "Finished!"

rails db:seed

About the chef

Now we want a route to display info about the chef of a restaurant.

  GET /restaurants/42/chef

rails generate migration AddChefNameToRestaurants chef_name:string
rails db:migrate

Member

# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants do
    member do
      get :chef
    end
  end
end

rails routes | grep chef
# Prefix           Verb URI Pattern                      Controller#Action
# chef_restaurant  GET  /restaurants/:id/chef(.:format)  restaurants#chef

Controller

# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [ :chef ]

  def chef
    @chef_name = @restaurant.chef_name
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end

# Nested Resources
# Adding reviews

# We want to let users leave a review about a restaurant, and display them on the restaurant's page.
# models

rails generate model Review content:text restaurant:references
rails db:migrate

# app/models/restaurant.rb
class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
end

# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :restaurant
end
