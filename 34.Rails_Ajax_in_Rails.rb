#
# https://kitt.lewagon.com/knowledge/tutorials/fetch_in_rails
# <%= pluralize @restaurant.reviews.size, "review" %>
#
#
gem 'turbolinks_render'
rails webpacker:install:stimulus


class Application < Rails::Application
  config.action_view.embed_authenticity_token_in_remote_forms = true
  # [...]
end
# We want to add reviews to a restaurant, with the form inlined in the restaurant show view.
# Add a new route
# config/routes.rb
Rails.application.routes.draw do
  resources :restaurants, only: [ :index, :show ] do
    resources :reviews, only: :create
  end
end

rails g controller reviews
# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  def create
    @restaurant=Restaurant.find(params[:restaurant_id])
    @review=Review.new(review_params)
    @review.restaurant=@restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant, anchor: "{#{review-@review.id}")

    else render 'restaurants/show'
    end

    def destroy
      @restaurant=Restaurant.find(params[:id])
      @restaurant.destroy
      redirect_to restaurants_path
      redirect_to restaurant_path(@restaurant, anchor: "{#{review-@review.id}")
    end

    private
    def review_params params.require(:review).permit(:content)
    end

  end

  # Let's ajaxify this app
  <!-- app/views/restaurants/show.html.erb -->
  <!-- [...] -->

  <%= simple_form_for([ restaurant, review ], remote: true) do |f| %>
    <%= f.input :content %>
    <%= f.button :submit %>
  <% end %>

  ### avoid scrolling to new reviews
  # use the id in the controller =>

  <div id="reviews">
  <% if @restaurant.reviews.blank? %>
  Be the first to leave a review for <%= @restaurant.name %>
  <% else %>
  <% @restaurant.reviews.each do |review| %>
    <p id="review-<%= review.id %>"><%= review.content %></p>
    <%= link_to "Delete", restaurant, method: :delete, remote: true %>
  <% end %>
<% end %>
</div>

# config/application.rb
# ADD THIS !!!

# [...]
class Application < Rails::Application
  config.action_view.embed_authenticity_token_in_remote_forms = true
  # [...]
end
## Can be used on DETELE also

<!-- app/views/restaurants/index.html.erb -->
<ul>
<% @restaurants.each do |restaurant| %>
  <li>
  <%= restaurant.name %>
  <%= link_to "Delete", restaurant, method: :delete, remote: true %>
  </li>
<% end %>
</ul>
# app/controllers/restaurants_controller.rb
class RestaurantsController < ApplicationController
  # TODO: Add `:destroy` in `config/routes.rb`
  def index
    @restaurants = Restaurant.all
    respond_to do |format|
      format.html
      format.json { render json: { restaurants: @restaurants } }
    end

    def destroy
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      redirect_to restaurants_path
    end
  end

  ## END HOWEVER IT CAN F UP !! ##

  ## Dynamic Counter ##
  class ApplicationController
    before_action :set_counter

    private

    def set_counter
      @restaurant_count = Restaurant.count
    end
  end

  ## view
  <!-- app/views/pages/home.html.erb -->
  <div class="flex-center mt-4">
  <div class="badge badge-primary p-3 mr-3">
  <span><%= @restaurant_count %></span>
  </div>

  <button class="btn btn-outline-secondary">Refresh counter</button>
  </div>

  ## CSS
  #// app/assets/stylesheets/components/_counter.scss

  .flex-center {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .counter {
    width: 56px;
    border-radius: 50%;
    color: white;
    text-align: center;
    padding: 1rem;
    background-color: #7e73ff;
    margin-right: 2rem;
  }


  ###
  ## Stimulus JS
  # https://stimulusjs.org/handbook/origin
  #

  # querySelector is replaced by data-target
  # addEventListener is replaced by data-action
  # the data-controller wraps the other elements

  data-controller="controller-name"
  data-target="controller-name.targetName"
  data-action="event->controller-name#actionName"

  #
  touch app/javascript/controllers/counter_controller.js

  ## Template counter_controller
  import { Controller } from "stimulus";

  export default class extends Controller {
    connect() {
      console.log('Hello!');
    }
  }

  ## HTML ADD data-controller !! to the div

  <div class="flex-center mt-4" data-controller="counter">
  <div class="counter">
  <span><%= @restaurant_count %></span>
  </div>

  <button class="btn btn-outline-secondary">Refresh counter</button>
  </div>

  ## Add a tartets HTML
  #
  #
  <div class="flex-center mt-4" data-controller="counter">
  <div class="counter">
  <span data-target="counter.count"><%= @restaurant_count %></span>
  ## count is like getElementById
  </div>

  <button class="btn btn-outline-secondary"
  data-action="click->counter#refresh">Refresh counter</button>
  </div>

  ## targets_controller

  import { Controller } from "stimulus";

  export default class extends Controller {
    static targets = [ 'count' ];

    connect() {
      console.log(this.countTarget);
      # get all below
      console.log(this.countTargets);
    }

    refresh(event) {

      console.log(event);
      console.log("you clicked !!");

      fetch('/restaurants', { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
              console.log(data);
              this.countTarget.innerText = data.restaurants.length;
      });
      ## replace the count with new coutn
    }
  }

  ## Automatic Refresh
  #
  #
  import { Controller } from "stimulus";

  export default class extends Controller {
    static targets = [ 'count' ];

    connect() {
      setInterval(this.refresh, 5000);
    }

    refresh = () => {
      console.log("5 secs have past");
      fetch('/restaurants', { headers: { accept: "application/json" }})
      .then(response => response.json())
      .then((data) => {
              this.countTarget.innerText = data.restaurants.length;
      });
    }
  }
