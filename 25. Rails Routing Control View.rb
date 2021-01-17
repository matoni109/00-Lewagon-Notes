## strftimer.com
##
@time = Date.today.strftime("%B #{Date.today.day.ordinalize}")

cd ~/code/$GITHUB_USERNAME

Then create a new rails 6.0 app with:

  rails new first-rails-app --skip-active-storage --skip-action-mailbox

This creates a new folder ~/code/$GITHUB_USERNAME/first-rails-app.
  Set up git

cd first-rails-app
pwd
# => ~/code/$GITHUB_USERNAME/first-rails-app

git add . && git commit -m "rails new"

** hub create

or

git remote -v
# => An `origin` remote is now set!

git push origin master  # Push the generated rails app to GitHub
gh repo view --web      # Will open your browser to the new director

## start rails => rails s
## route => action => views

rails generate controller pages
.then =>
  rails generate controller pages index show # rails g controller pages
#      create  app/controllers/pages_controller.rb
#      invoke  erb
#      create    app/views/pages

# config/routes.rb
# rails routes => prints all routes
Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about', as: :about # extra :)
  get 'contact', to: 'pages#contact', as: :contact
  # Generic syntax:
  # verb 'path', to: 'controller#action' #prefix/ alias
  get "/flats/:id", to: "flats#show", as: :flat
end


# find
@flat = @flats.find {|flat| flat["id"] == @id.to_i }

# app/controller/pages_controller.rb
class PagesController < ApplicationController

  before_action :fetch_flats, only: [:show, :index]

  def home
  end

  def about
  end

  def contact # coming from about
    # raise
    @search = params[:client_email]

    if search.present?
      @members = @members.select { |name| name.downcase == search.downcase}
    else
      @members = ['paris','perth','somePlace']
    end

    def new
      # TODO: generate random grid of letters
      gen_grid = ('A'..'Z').to_a + ('A'..'N').to_a
      @letters = gen_grid.sample(10)
      session[:passed_variable] = @letters
    end

    def score
      # binding.pry
      @letters = session[:passed_variable]
      @attempt = params[:word]

      url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
      word_back = open(url).read
      word_hash = JSON.parse(word_back)

    end


    private
    def fectch_flats

    end


    # now make the view
    View
    # pe + tab => erb tags
    # er + tab
    # 37 mins
    # vars are in the controller

    #<!-- app/views/pages/about.html.erb -->
    <h1>Our first view 🚀</h1>

    <% @cities.each do |city| %>
      <p> <%= city %> </p>
    <% end % >


    <h4> tell us who you are and contact us </h4>

    # <form action="/contact">
    # < input type="text" name="client_email">
    # < input type='submit' value='contact us ">
    #  #</form>

    ## links in rails
    <%= link_to ANCHOR_TEXT, ANCHOR_URL %>
    # example
    <%= link_to "Learn About US", about_path, class: "class here" %>
    flat_path

    ### components code in :
    <!-- app/views/layouts/application.html.erb -->

    ### Ruby in the view
    <!-- app/views/pages/contact.html.erb -->
    <% members = [ 'thanh', 'dimitri', 'germain', 'damien', 'julien' ] %>

    <h2>Meet our team</h2>
    <ol>
    <% members.each do |member| %>
      <li><%= member.capitalize %></li>
    <% end %>
    </ol>

    <ol>
    <% @members.each do |member| %>
      <li><%= member.capitalize %></li>
    <% end %>
    </ol>


    ## more forms

    #<!-- app/views/pages/contact.html.erb -->
    <form action="/contact" method="get">
    <input type="text" name="member" placeholder="Who are you looking for?">
    <input type="submit">
    </form>


    <input type="text"
    name="member"
    value="<%= params[:member] %>"
    placeholder="Who are you looking for?">
