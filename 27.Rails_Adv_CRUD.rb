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
  has_many :reviews, dependent: :destroy # @restaurant.reviews
end

# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :restaurant

  validates :content, presence: true
end

# then
rails g controller reviews

# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants do
    resources :reviews, only: [ :new, :create ]
  end
end

#            Prefix  Verb  URI Pattern                              Controller#Action
# new_restaurant_review  GET   /restaurants/:restaurant_id/reviews/new  reviews#new
#    restaurant_reviews  POST  /restaurants/:restaurant_id/reviews      reviews#create



# <!-- app/views/restaurants/show.html.erb -->

# <!-- ... -->

#<%= link_to 'Edit', edit_restaurant_path(@restaurant) %> |
#<##%= link_to 'Back', restaurants_path %> |
# <%= link_to 'Leave a review', new_restaurant_review_path(@restaurant) %> ##
# ##

# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  def new
    # we need @restaurant in our `simple_form_for`
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # we need `restaurant_id` to associate review with corresponding restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    @review.save
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant)
  end
  private

  def review_params
    params.require(:review).permit(:content)
  end

  touch app/views/reviews/new.html.erb

  !-- app/views/reviews/new.html.erb -->
  <%= simple_form_for [ @restaurant, @review ] do |f| %>
    <%= f.input :content %>
    <%= f.submit "Submit review", class: "btn btn-primary" %>
  <% end %>


  ## show page with reviews
  <!-- app/views/restaurants/show.html.erb -->

  <!-- ... -->
  <ul class="list-group">
  <% @restaurant.reviews.each do |review| %>
    <li class="list-group-item"><%= review.content %></li>
  <% end %>
  </ul>
  <!-- ... -->


  Rails.application.routes.draw do
    resources :restaurants do

      collection do #   # collection => no restaurant id in URL
        get :top # RestaurantsController#top
      end
      member do # member => restaurant id in URL
        get :chef # RestaurantsController#chef
      end
      # needs resturant IDS
      resources :reviews, only: [ :new, :create ]
    end
    # outside of Restaurants
    resources :reviews, only: [ :destroy, :show, :update ]
  end


  <li class="list-group-item">
  <%= review.content %>
  <%= link_to "Remove",
    review_path(review),
    method: :delete,
    data: { confirm: "Are you sure?" } %>
  </li>

  # app/models/restaurant.rb
  class Restaurant < ApplicationRecord
    validates :rating, inclusion: { in: [1,2,3], allow_nil: false }
    validates :rating, inclusion: { in: [0,1,2,3], allow_nil: false }
    validates :name, uniqueness: true, presence: true
    validates :address, presence: true
  end


  tchai = Restaurant.new(name: "L'esprit Tchaï", stars: 1)
  tchai.valid?
  # => false
  tchai.errors.full_messages
  # => ["Address can't be blank"]
