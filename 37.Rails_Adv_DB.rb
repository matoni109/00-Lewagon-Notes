#
# Rails Advanced DB
# https://blazer.dokkuapp.com/
# heroku config:set BLAZER_DATABASE_URL=$(heroku config:get DATABASE_URL)
heroku config:get DATABASE_URL
# postgres://yljijpdatgvnly:9b96e86a06bb9a4985a14a2ff76876811c8730aa43cd9ef862fdb317348a9848@ec2-174-129-195-73.compute-1.amazonaws.com:5432/ddr5i0l4lep60o
#
# N+1 queries (foreword)
# Performance GEMS
# https://github.com/flyerhzm/bullet
# https://kitt.lewagon.com/knowledge/tutorials/n_plus_one
#
#
# https://github.com/MiniProfiler/rack-mini-profiler
#
# https://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations
# datasets
# https://www.kaggle.com/
#
# Admin Alts
# https://github.com/activeadmin/activeadmin
# https://kitt.lewagon.com/knowledge/tutorials/rails_admin
#
# https://www.forestadmin.com/
# https://kitt.lewagon.com/knowledge/tutorials/forest_admin
#

# books controller
def index
  @books = Book.all
end

#
 SELECT "books".* FROM "books"

 #view
<% @books.each do |book| %>
  <strong><%= book.title %></strong> by <%= book.author.name %>
<% end %>
#=>

## streamline
# books controller
# loads all the author ID's
def index
  @books = Book.includes(:author)
end

## displaying DATA
#
#
Rails rails_admin
bundle install
rails g rails_admin:install

# where do I want to put adin
=> press enter for default
#
user = User.last
user.admin = true
user.save

# setup Devise
# config/initializers/rails_admin.rb
# [...]
config.authenticate_with do
  warden.authenticate! scope: :user
end
config.current_user_method(&:current_user)
# [...]
#
# the important part !!
# config/initializers/rails_admin.rb
# [...]
config.authorize_with do
  unless current_user.admin?
    flash[:alert] = 'Sorry, no admin access for you.'
    redirect_to main_app.root_path
  end
end

##
# config/initializers/rails_admin.rb
# [...]
config.included_models = [ "Seller", "Product", "User" ]
#
#


## BLAZER!!! ##
#
#
# Gemfile
gem 'blazer'

bundle install
rails g blazer:install
rails db:migrate
# https://github.com/ankane/blazer
#
# config/routes.rb
authenticate :user, ->(user) { user.admin? } do
  mount Blazer::Engine, at: "blazer"
end
# Draw a line chart with the Monthly orders (in #)
SELECT date_trunc('month', purchased_at)::date, COUNT(*)
FROM orders
GROUP BY 1;

##  The price is only available in the order_items table
SELECT order_id, SUM(price) AS amount
FROM order_items
GROUP BY 1

# Using the last query as a subquery, we can now add a Monthly gross revenue query
WITH orders_with_amount AS (
  SELECT order_id, SUM(price) AS amount
  FROM order_items
  GROUP BY 1
)

SELECT date_trunc('month', purchased_at)::date, SUM(orders_with_amount.amount)
FROM orders
JOIN orders_with_amount ON orders.id = orders_with_amount.order_id
GROUP BY 1;

### Create a Monthly revenue per category query with a {category} variable:
##
#
# {category is dynamic }
WITH orders_with_amount AS (
  SELECT order_id, SUM(price) AS amount
  FROM order_items
  GROUP BY 1
)

SELECT date_trunc('month', purchased_at)::date, SUM(orders_with_amount.amount)
FROM orders
JOIN orders_with_amount ON orders.id = orders_with_amount.order_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE products.category_name = {category}
GROUP BY 1;

## To replace the input by a dropdown with all categories:

# config/blazer.yml

smart_variables:
  category: |
    SELECT DISTINCT category_name
    FROM products
    ORDER BY category_name ASC

#
# Let's add a Top 10 sellers query
WITH orders_with_amount AS (
  SELECT order_id, SUM(price) AS amount
  FROM order_items
  GROUP BY 1
)

SELECT sellers.name, SUM(orders_with_amount.amount)
FROM orders
JOIN orders_with_amount ON orders.id = orders_with_amount.order_id
JOIN order_items ON orders.id = order_items.order_id
JOIN sellers ON order_items.seller_id = sellers.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

##
#
# Let's add a Daily revenue per period query

WITH orders_with_amount AS (
  SELECT order_id, SUM(price) AS amount
  FROM order_items
  GROUP BY 1
)

SELECT date_trunc('day', purchased_at)::date, SUM(orders_with_amount.amount)
FROM orders
JOIN orders_with_amount ON orders.id = orders_with_amount.order_id
WHERE purchased_at >= {start_time} AND purchased_at <= {end_time}
GROUP BY 1;

## User a target
SELECT date_trunc('week', rated_at)::date AS week,
COUNT(*) AS new_ratings, 5000 AS target
FROM ratings GROUP BY week ORDER BY week
##

