## Rails CRUD
## <!-- MapBOX
# map_token = pk.eyJ1IjoibWF0b25pMTA5IiwiYSI6ImNraTZzN3hpeTAxdjQyeXBndDFld2cwODgifQ.QDVAsTj3D_3wb7A3XGRP6g -->
#
# spring stop
rails new thespoon-with-activerecord --skip-active-storage --skip-action-mailbox

## now for models
rails generate model Restaurant name:string rating:integer
## then
check migration !
##
rails db:migrate
##
check schema
## routes.rb
resources :pets
## then
rails g controller pets # ( PURAL!!! )

<#%=render form, pet: @pet %>

## AUTO GEN FILES
# db/migrate/YYYYMMDDHHMMSS_create_restaurants.rb
class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end

# app/models/restaurant.rb
class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy #

  validates :name, presence: true
  validates :address, presence: true
  validates :rating, inclusion: { in: 1..5 }
  # inclusion: {in: SPECIES}
end

## then run ( always after each model )
rails db:migrate

## to view console
rails c
reload!

## sandbox mode
rails console --sandbox

## to add/destroy an address to the Restaurants ActRec Table

rails generate migration AddAddressToRestaurants address:string

## then
rails db:migrate

## more migration info:
# => https://edgeguides.rubyonrails.org/active_record_migrations.html

# rails db:drop - Drop the database (lose all your data!)
# rails db:create - Create the database with an empty schema
# rails db:migrate - Run pending migrations on the database schema
# rails db:rollback - Revert the last migration
# rails db:reset - Drop database + create tables found in schema.rb

##
##  C   R   U   D ##
##

# READ ALL

# config/routes.rb
Rails.application.routes.draw do
  # verb "path", to: 'controller#action'

  # read all
  get '/restaurants', to: 'restaurants#index', as: :pets
  # read one
  get '/restaurant/:id', to: 'restaurants#show', as: :pet

  # create a restaurant
  get '/restaurants/new', to: 'restaurants#new', as: :new_pet
  post '/restaurant/new', to: 'restaurants#create' #NIL

  # update a restaurant
  get '/restaurants/:id/edit', to: 'restaurants#edit', as: :edit_pet
  patch '/restaurant/:id', to: 'restaurants#update'
  # delete a resturant
  delete '/restaurants/:id', to: 'restaurants#destroy'

  ######## or
  resources :restaurants, #only [:create, :index, :destroy]
    end

## now Controller time
#
# =>
rails g controller restaurants index show

class RestaurantsController < ApplicationController

  before_action :find_restaurant, only[:show, :update, :edit, :destroy]
  #READ
  def index
    @restaurants = Restaurant.all
  end

  def show
    # @restuarants = Restaurant.find(params[:id])
  end
  #CREATE
  def new
    @restaurant = Restaurant.new # needed to instantiate the form_for
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      # no need for app/views/restaurants/create.html.erb
      redirect_to restaurant_path(@restaurant) # restaurants ( pural will take u to All )
    else
      render :new
    end
  end

  # UPDATE
  def edit
    # @restuarants = Restaurant.find(params[:id])
  end

  def update
    # @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      # no need for app/views/restaurants/update.html.erb
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destory
    # @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    # no need for app/views/restaurants/destroy.html.erb
    redirect_to restaurants_path

    private

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :rating)
    end

    def find_restaurant_params
      @restaurant = Restaurant.find(params[:id])
    end
  end


  ## <%= link_to task.title, root_path %>
  # <!-- app/views/restaurants/index.html.erb -->
  <ul>
  <% @restaurants.each do |restaurant| %>
    <li><%= restaurant.name %></li>
    <li><%= 'emogi' x restaurant.rating %></li>
  <% end %>
  </ul>

  # <!-- app/views/restaurants/show.html.erb -->
  <h2><%= @restaurant.name %></h2>
  <p><%= @restaurant.address %></p>
  <p><%= @restaurant.rating %></p>

  <%= link_to "back", restaurant_path %>
  <%= link_to "edit", edit_restaurant_path(@restaurant) %>
  <%= link_to "Delete #{@restaurant.name}",
    restaurant_path(@restaurant),
    method: :delete,
    data: { confirm: "Are you sure?" } %>

  # <!-- app/views/restaurants/new.html.erb -->
  # https://guides.rubyonrails.org/form_helpers.html#binding-a-form-to-an-object
  <%= form_for(@restaurant) do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.label :address %>
    <%= f.text_field :address %>
    <%= f.label :rating %>
    <%= f.number_field :rating %>
    <%= f.submit %>
  <% end %>

  ## <!-- app/views/restaurants/edit.html.erb -->
  <%= form_for(@restaurant) do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.label :address %>
    <%= f.text_field :address %>
    <%= f.label :rating %>
    <%= f.number_field :rating %>
    <%= f.submit %>
  <% end %>

  ## faker
  #
  gem 'faker'
  gem 'simple_form'
  bundle install
  rails generate simple_form:install --bootstrap

  ###
  bootstrap
  yarn add bootstrap
  rm app/assets/stylesheets/application.css
  touch app/assets/stylesheets/application.scss
  // app/assets/stylesheets/application.scss
  @import "bootstrap/scss/bootstrap";

  ##
  # => seeds.rb rails db:seeds

  100.times do
    Restaurant.create(
      name: "fa",
      address: "fa",
      rating: rand(1..5)
    )
  end

  ## Link to helper
  # <%= link_to(title, path) %>
  #<!-- app/views/restaurants/index.html.erb -->
  <ul>
  <% @restaurants.each do |restaurant| %>
    <li><%= link_to restaurant.name, restaurant_path(restaurant) %></li>
  <% end %>
  </ul>
  # <a href="/restaurants/1">Chez Gladines</a>


  #### refactor partials
  ##
  #
  <!-- app/views/restaurants/_form.html.erb -->
  <%= form_for(restaurant) do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.label :address %>
    <%= f.text_field :address , collection: Pet::SPECIES%>
    <%= f.label :rating %>
    <%= f.number_field :rating %>
    <%= f.submit %>
  <% end %>

  #<!-- app/views/restaurants/new.html.erb -->
  <%= render "form", restaurant: @restaurant %>

  #<!-- app/views/restaurants/edit.html.erb -->
  <%= render "form", restaurant: @restaurant %>


  ## Using simple form

  <!-- app/views/restaurants/_form.html.erb -->
  <%= simple_form_for(restaurant) do |f| %>
    <%= f.input :name %>
    <%= f.input :address %>
    <%= f.input :rating %>
    <%= hidden_field_tag :grid_letters, @letters %>
    <%= f.submit %>
  <% end %>
