#
#
# https://www.toptal.com/ruby-on-rails/top-10-mistakes-that-rails-programmers-make
## current_user helper in app/controllers/application_controller
require 'ostruct'

helper_method :current_user

def current_user
  @current_user ||= User.find session[:user_id] if session[:user_id]
  if @current_user
    @current_user
  else
    OpenStruct.new(name: 'Guest')
  end
end

<h3>Welcome, <%= current_user.name -%></h3>
##
#https://github.com/heartcombo/devise
#https://github.com/lewagon/rails-templates/tree/master#minimal
#
# start with Minimal
https://github.com/lewagon/rails-templates/tree/master#minimal

## devise

# Gemfile
gem 'devise'

bundle install
rails generate devise:install
rails g devise:views

#Some setup you must do manually if you haven't yet:

# # config/initializers/devise.rb

# # ==> Mailer Configuration
# # Configure the e-mail address which will be shown in Devise::Mailer,
# # note that it will be overwritten if you use your own mailer class
# # with default "from" parameter.
# config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'


rails generate devise User
#      invoke  active_record
#      create    db/migrate/TIMESTAMP_devise_create_users.rb
#      create    app/models/user.rb
#      insert    app/models/user.rb
#       route  devise_for :users

rails db:migrate

## logout
<%= link_to "Log out", destroy_user_session_path, method: :delete, class: "dropdown-item" %>


# app/models/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
end

rails routes
rails routes | grep new_

[1] pry(main)> User.count
[2] pry(main)> User.last

user_signed_in?
# => true / false

current_user
# => User instance / nil
current_user.email

if user_signed_in?
  current_user.email
end

## make navbar
mkdir app/views/shared
curl https://raw.githubusercontent.com/lewagon/awesome-navbars/master/templates/_navbar_wagon.html.erb > app/views/shared/_navbar.html.erb
curl https://raw.githubusercontent.com/lewagon/karr-images/master/white_logo_red_circle.png > app/assets/images/logo.png

<!-- app/views/layouts/application.html.erb -->
<%= render 'shared/navbar' %>

### Alerts

<!-- app/views/layouts/application.html.erb -->
<%= render 'shared/flashes' %>

<!-- app/views/shared/_flashes.html.erb -->
<% if notice %>
<div class="alert alert-info alert-dismissible" role="alert">
<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
<%= notice %>
</div>
<% end %>
<% if alert %>
<div class="alert alert-warning alert-dismissible" role="alert">
<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
<%= alert %>
</div>
<% end %>

f
### Controllers
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end
end


@bike.images.each do |image|
  image
end
