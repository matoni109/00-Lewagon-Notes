
## Associations
# Validatoins
# https://github.com/K-and-R/email_validator
# Set it up 1st
# https://kitt.lewagon.com/db/19645
# https://kitt.lewagon.com/db/20423
# new => https://kitt.lewagon.com/db
# DELETE FROM doctors WHERE id = 1;
# call .destroy_all on a model
#
# Active Record
#https://guides.rubyonrails.org/active_record_migrations.html#using-the-change-method
# https://apidock.com/rails/ActiveRecord/QueryMethods/order
#  https://guides.rubyonrails.org/active_record_querying.html#scopes
Draw the tables in db.lewagon.org

Create the migrations

Create the models

Don’t forget to strictly follow ActiveRecord’s naming
convention (table name
            lower_case plural, model name CamelCase singular)!

restaurant = Restaurant.new(name: "La Tour d'Argent")
restaurant.valid?
# => false
restaurant.errors.messages
# => { stars: [ "can't be blank" ] }

rake db:create

# make doctors
TIMESTAMP=`rake db:timestamp`
touch db/migrate/${TIMESTAMP}_create_doctors.rb

# make interns
TIMESTAMP=`rake db:timestamp`
touch db/migrate/${TIMESTAMP}_create_interns.rb

# make doctors class
class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string    :first_name
      t.string    :last_name
      t.timestamps null = false # add 2 columns, `created_at` and `updated_at`
    end
  end
end

class CreateInterns < ActiveRecord::Migration[6.0]
  def change
    create_table :interns do |t|
      t.string    :first_name
      t.string    :last_name
      t.references :doctor, foreign_key: true # for doctor_id
      t.timestamps null = false # add 2 columns, `created_at` and `updated_at`
    end
  end
end

## HOWTO Remove a column
class RemoveColumnFromTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :table, :column, :type
  end
end

## How To Change a Column Name
class RenameOldColumnInTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :table, :old_column_name, :new_column_name
  end
end

## How to add a new foreign key
class AddInternReferenceToPatients < ActiveRecord::Migration[6.0]
  def change
    add_reference :patients, :intern, foreign_key: true
  end
end



# now migrate
#
rake db:migrate

# Now time for the Models: singular !!!
touch doctor.#!/usr/bin/env ruby -wKU
  touch intern.#!/usr/bin/env ruby -wKU

class Doctor < ActiveRecord::Base
  has_many :interns
  # update
  has_many :consultations
end

# intern
class Intern < ActiveRecord::Base
  belongs_to :doctor

end

house = Doctor.new(first_name: "greg",last_name: "House" )
house.save

allison = Intern.new(first_name: "Allison",last_name: "Smith" )
#allison.doctor_id = house.id
allison.doctor = house
=> gives allison house foreign key
allison.save
Intern.all

jeff = Intern.new(first_name: "jeff", last_name: "cooper")
jeff.doctor = house
jeff.save

interns.doctor = house
# old way
jeff.doctor_id = house.id
#new way
jeff.doctor = house # is the object

##
allison.doctor
=> Dr House
allison.doctor.first_name
=> "gregory"

##
# create patients && consultations
# join them together with f_keys
#
TIMESTAMP=`rake db:timestamp`
touch db/migrate/${TIMESTAMP}_create_doctors.rb

class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      # has no foreign keys
      t.string    :first_name
      t.string    :last_name
      t.timestamps null = false # add 2 columns, `created_at` and `updated_at`
    end
  end
end


class CreateConsultations < ActiveRecord::Migration[6.0]
  def change
    create_table :consultations do |t|
      t.references :patient, foreign_key: true # for patient_id
      t.references :doctor, foreign_key: true # for doctor_id
      t.timestamps null = false # add 2 columns, `created_at` and `updated_at`
    end
  end
end


rake db:migrate

# Models Update
class Patient < ActiveRecord::Base[6.0]
  has_many :consultations
end

class Consultation < ActiveRecord::Base[6.0]
  belongs_to :patient
  belongs_to :doctor # update doctor.rb
end

seb = Patient.new(first_name: "seb", last_name: "saunier")
seb.save

boris = Patient.new(first_name: "boris", last_name: "paillard")
boris.save

flu = Consultation.new # no arguments
flu.patient = seb # give seb a flu consult
flu.doctor = house

stress = Consultation.new
stress.patient = boris
stress.doctor = house
stress.save

seb.consultations
=> array of consults

#update doctors
class Doctor < ActiveRecord::Base
  has_many :interns
  # update 1
  has_many :consultations
  # update 2 : Join them
  has_many :patients, through: :consultations
end

### VALIDATIONS ####
class Doctor < ActiveRecord::Base
  has_many :interns
  # update 1
  has_many :consultations
  # update 2 : Join them
  has_many :patients, through: :consultations

  validates :last_name, presence: true
  #saul.errors.message
  validates :last_name, uniqueness: true

  #All doctors must have a unique first_name last_name combination.
  validates :first_name, uniqueness: { scope: :last_name }
  # Doctor last names must be at least 3 characters.
  validates :last_name, length: { minimum: 3 }
  # validates with regex
  validates :email, format: { with: /\A.*@.*\.com\z/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end

### END ###

class Developer < ActiveRecord::Base
  validates :description, length: { minimum: 120 }
end

UPDATE doctors SET specialty = 'Strange Diseases' WHERE id = 1;

class CreateCategoriesPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_posts do |t|
      t.references :post, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end

class Post < ActiveRecord::Base
  has_many :categories_posts
  has_many :categories, through: :categories_posts
end

class Category < ActiveRecord::Base
  has_many :categories_posts
  has_many :posts, through: :categories_posts
end

class CategoriesPost < ActiveRecord::Base
  belongs_to :category
  belongs_to :post
end

### From Lecture ###
class CreateConsultations < ActiveRecord::Migration[6.0]
  def change
    create_table :consultations do |t|
      t.references :patient, foreign_key: true # for patient_id
      t.references :doctor, index: true # for doctor_id
      t.timestamps null = false # add 2 columns, `created_at` and `updated_at`
    end
  end
end

# Adding / Removing a column

# db/migrate/20141027200800_add_age_to_patients.rb
class AddAgeToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :age, :integer
  end
end

# db/migrate/20141027201000_remove_age_from_patients.rb
class RemoveAgeFromPatients < ActiveRecord::Migration[6.0]
  def change
    remove_column :patients, :age
  end
end

# Adding a foreign key

# Say that an intern has to take care of many patients.

# db/migrate/20141027201300_add_intern_reference_to_patients.rb
class AddInternReferenceToPatients < ActiveRecord::Migration[6.0]
  def change
    add_reference :patients, :intern, foreign_key: true
    # patient needs an intern
    # Post needs a user
  end
end


class User < ActiveRecord::Base
  has_many :posts

  before_validation :ensure_email_is_stripped

  # TODO: Add some validation
  validates :username, :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # TODO: Add some callbacks
  after_create :send_welcome_email

  private
  def ensure_email_is_stripped
    self.email.strip! unless email.nil?
  end

  def send_welcome_email
    FakeMailer.instance.mail(self.email, "Welcome Email")
  end

end




### Sinatra Examples <head>
<!--  <link rel="stylesheet" href="style.css"> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
</head>

<div>
<h1><%= @post.title %></h1>
<p><%= @post.url %></p>
<p><%= @post.votes %></p>
<a href="/">Back</a>
</div>
# TODO: list posts here. You can use instance variables set in the controller (app.rb)
<div>
<ul>
<% @posts.each do |post| %>
  <li>
  <!--   <%= post.title %> -->
  <a href="/post/<%= post.id %>" target="_self"><%= post.title %> (<%= post.votes %> Votes)</a>
  </li>
<% end %>
</ul>
</div>


<h2>Posts from solution below</h2>
<ul>
<% @posts.each do |post| %>
  <li>
  <a href="<%= post.url %>" target="_blank"><%= post.title %> (<%= post.votes %> votes)</a>
  <form action="/posts/<%= post.id %>/upvote" method="POST">
  <input type="hidden" name="_method" value="PUT">
  <input type="submit" value="upvote"/>
      </form>
  </li>
<% end %>
</ul>



<h2>Add new post</h2>

<% if @post.errors.present? %>
<p>
Unable to create the Post. Please review following errors:<br/>
<strong><%= @post.errors.full_messages.join(' and ') %></strong>
</p>
<% end %>
# from to add a post ##
<form action="/posts" method="POST">
<label for="title">Title</label>
<input type="text" name="title" id="title" value="<%= params[:title] %>"/>

  <label for="url">URL</label>
<input type="text" name="url" id="url" value="<%= params[:url] %>"/>

  <input type="submit" value="Add"/>
</form>


### LOGIC
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative "config/application"

set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'

get '/' do
  # TODO
  # 1. fetch posts from database.
  @posts = Post.by_most_popular
  erb :posts # Do not remove this line
end

# TODO: add more routes to your app!
get "/post/:id" do
  @post = Post.find(params[:id])
  erb :post
end


# Post upvote
put '/posts/:id/upvote' do
  post = Post.find(params[:id])
  post.votes += 1
  post.save

  redirect to('/')
end

# # Post creation
post '/posts' do
  @post = Post.new
  @post.title = params[:title]
  @post.url = params[:url]
  @post.user = User.first
  @post.save

  if @post.save
    redirect to('/')
  else
    erb :new_post
  end
end
