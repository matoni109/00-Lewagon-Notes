# 29.Rails_Hosting_IMG.rb
# https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
# https://github.com/rails/rails/issues/33463#issuecomment-511151950
# EDITOR='subl --wait' rails credentials:edit
# https://stackoverflow.com/questions/60780151/how-to-use-rails-5-2-credentials-in-another-yml-file
# Rails.application.credentials.cloudinary.fetch(:api_key)
Heroku
https://id.heroku.com/signup
heroku
Usage: heroku COMMAND [--app APP] [command-specific-options]
Primary help topics, type "heroku help TOPIC" for more details:
  addons     # manage addon resources
apps       # manage apps (create, destroy)
auth       # authentication (login, logout)
config     # manage app config vars
domains    # manage custom domains
logs       # display logs for an app
ps         # manage dynos (dynos, workers)
releases   # manage app releases
run        # run one-off commands (console, rake)
sharing    # manage collaborators on an app

### run after models setup
rails active_storage:install # copies the migration files
rails db:migrate

## setup You should add a root route (url "/").

heroku login
heroku create $YOUR_APP_NAME --region us

git remote -v

## Push your app to Heroku
git push heroku master

heroku open         # open in your browser
heroku logs --tail  # show the app logs and keep listening

heroku run <command>         # Syntax
heroku run rails db:migrate  # Run pending migrations in prod
heroku run rails c           # Run the production console


## cloudinary https://cloudinary.com/users/register/free
# Gemfile
gem 'dotenv-rails', groups: [:development, :test]
bundle install

touch .env
echo '.env*' >> .gitignore

git status # .env should not be there, we don't want to push it to Github.
git add .
  git commit -m "Add dotenv - Protect my secret data in .env file"

# Gemfile
gem 'cloudinary', '~> 1.16.0'
bundle install
# config/environments/production.rb
config.active_storage.service = :cloudinary

heroku config:set CLOUDINARY_URL=cloudinary://166....
  # .env
  CLOUDINARY_URL=cloudinary://298522699261255:Qa1ZfO4syfbOC-***********************8
## check with
heroku config

##
curl https://c1.staticflickr.com/3/2889/33773377295_3614b9db80_b.jpg > san_francisco.jpg
curl https://pbs.twimg.com/media/DC1Xyz3XoAAv7zB.jpg > boris_retreat_2017.jpg

# rails c
Cloudinary::Uploader.upload("san_francisco.jpg")
Cloudinary::Uploader.upload("boris_retreat_2017.jpg")
rm san_francisco.jpg boris_retreat_2017.jpg

##
class Product < ApplicationRecord
  has_one_attached :photo
  # OR
  has_many_attached :photos

  # This is where you define the name of the attachment, it doesn't necessarily have to be :photo / :photos!
end
#<!-- app/views/articles/index.html.erb -->
<%= cl_image_tag("THE_IMAGE_ID_FROM_LIBRARY",
                 width: 400, height: 300, crop: :fill) %>

#<!-- for face detection -->
<%= cl_image_tag("IMAGE_WITH_FACE_ID",
                 width: 150, height: 150, crop: :thumb, gravity: :face) %>

<!-- app/views/products/show.html.erb -->
<%= cl_image_tag @product.photo, brightness: 30, radius: 20,
  width: 150, height: 150, crop: :thumb, gravity: :face %>

#https://cloudinary.com/documentation/image_transformations#transformations_reference

## config
# config/storage.yml
cloudinary:
  service: Cloudinary

## make below change

# config/environments/development.rb
config.active_storage.service = :cloudinary


# model

class Article < ApplicationRecord
  has_one_attached :photo
end

## view and controller

<!-- app/views/articles/_form.html.erb -->
<%= simple_form_for(article) do |f| %>
  <!-- [...] -->
  <%= f.input :photo, as: :file %>
  <!-- [...] -->
<% end %>

# app/controllers/articles_controller.rb
def article_params
  params.require(:article).permit(:title, :body, :photo)
end


<!-- app/views/articles/show.html.erb -->
<%= cl_image_tag @article.photo.key, height: 300, width: 400, crop: :fill %>

@article.photo.attached?

<div class="card-category" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('<%= cl_image_path @article.photo.key, height: 300, width: 400, crop: :fill %>')">
Cool article
</div>


### Seeds
require "open-uri"

file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
article = Article.new(title: 'NES', body: "A great console")
article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
article.save!

Helpful Active Storage methods

@article.photo.attached? #=> true/false
@article.photo.purge #=> Destroy the photo

class Article < ApplicationRecord
  has_many_attached :photos
end

## simple form add many images
<!-- app/views/articles/_form.html.erb -->
<%= simple_form_for(article) do |f| %>
  <!-- [...] -->
  <%= f.input :photos, as: :file, input_html: { multiple: true } %>
  <!-- [...] -->
<% end %>

Change params to an array []

# app/controllers/articles_controller.rb
def article_params
  params.require(:article).permit(:title, :body, photos: [])
end

<!-- app/views/articles/show.html.erb -->
<% @article.photos.each do |photo| %>
  <%= cl_image_tag photo.key, height: 300, width: 400, crop: :fill %>
<% end %>


# https://guides.rubyonrails.org/action_text_overview.html
