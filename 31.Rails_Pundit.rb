#
#
# https://github.com/ankane/pretender
# Gemfile
gem 'pretender'
gem 'pundit'

bundle install
rails g pundit:install

Pundit Setup (2)

## paste into application contrioller
class ApplicationController < ActionController::Base
  # [...]
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end

# Usage
# Protect Restaurant
### =>

rails g pundit:policy restaurant
# => generates the file `app/policies/restaurant_policy.rb`

### in Application_Policy.rb

# in restaurant controller
class RestaurantController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    # @restaurants = Restaurant.all
    @restaurants = policy_scope(Restaurant).order(created_at: :desc)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new

    authorize @restaurant ## this is in set_rest
  end

  def create
    # [...]
    authorize @restaurant
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    @restaurant = Restaurant.find(params[:id])
  end
end


# <% if policy(Restaurant).create? %>
#   <%= link_to "New restaurant", new_restaurant_path %>
# <% end %>

# app/policies/restaurant_policy.rb
class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end

    def index?
      return true
    end


    def new?
      return true
    end

    # Edit calls update ? in App Policy
    # def edit?
    #   # if user is own true otherwise false
    #   # user => current user
    #   #record => @restaurant ( arg passed to 'authorize' )
    #   user == record.user ? true : false
    # end

    def update?
      user_is_owner_or_admin?
      # - record: the restaurant passed to the `authorize` method in controller
      # - user:   the `current_user` signed in with Devise.
    end

    def destroy?
      user_is_owner_or_admin?
    end

    private

    def user_is_owner_or_admin?
      user == record.user || user.admin
    end
  end


  In the view we can use policy with an instance.

  <% @restaurants.each do |restaurant| %>
    <% if policy(restaurant).edit? %>
    <%= link_to "Update", edit_restaurant_path(restaurant) %>
  <% end %>
<% end %>

<% if policy(Restaurant).new %>
<%= link_to 'New Restaurant', new_restaurant_path %>
<% end %>

# Admin users

rails g migration AddAdminToUsers admin:boolean
rails db:migrate

# rails c
pry> user = User.where(email: 'seb@lewagon.org').first
pry> user.admin = true
pry> user.save

You can now use this admin field in your policies!
Happy Authorizing!
2
