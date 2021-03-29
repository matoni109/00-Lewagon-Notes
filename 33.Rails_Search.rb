## Rails Seach
#
# https://pablo-curell-mompo.medium.com/understanding-and-tweaking-pg-search-62c125b2ded1
# Gemfile
gem 'pg_search', '~> 2.3.0'
# https://github.com/Casecommons/pg_search#tsearch-full-text-search
rails g pg_search:migration:multisearch
rails db:migrate
##
rails g model director first_name last_name
rails g model movie title year:integer synopsis:text director:references
rails g model tv_show title year:integer synopsis:text

rails db:migrate

require "open-uri"
require "yaml"

file = "https://gist.githubusercontent.com/ssaunier/25920c896baa0e4495fd/raw/9c26ce104c15fc237126bf6b136b8e318368f8ad/imdb.yml"
sample = YAML.load(open(file).read)

puts 'Creating directors...'
directors = {}  # slug => Director
sample["directors"].each do |director|
  directors[director["slug"]] = Director.create! director.slice("first_name", "last_name")
end

puts 'Creating movies...'
sample["movies"].each do |movie|
  Movie.create! movie.slice("title", "year", "synopsis").merge(director: directors[movie["director_slug"]])
end

puts 'Creating tv shows...'
sample["series"].each do |tv_show|
  TvShow.create! tv_show
end
puts 'Finished!'

## Add routes

Rails.application.routes.draw do
  root to: 'pages#home'
  resources :movies, only: :index
end


## controller and view

class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
end

<div class="container">
<div class="row">
<div class="col-sm-8 offset-sm-2">
<div id="movies">
<% @movies.each do |movie| %>
  <h4><%= movie.title %></h4>
  <p><%= movie.synopsis %></p>
<% end %>
</div>
</div>
</div>
</div>

#####
# Search Form #
<%= form_tag movies_path, method: :get do %>
  <%= text_field_tag :query,
    params[:query],
    class: "form-control",
    placeholder: "Find a movie"
  %>
  <%= submit_tag "Search", class: "btn btn-primary" %>
<% end %>
<!-- the list of movies -->
###
##
# using active record
# movies controller
class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = Movie.where(title: params[:query])
      @movies = Movie.all if @movies.empty?
    else
      @movies = Movie.all
    end
  end
end


#### But super wont return Superman Returns
class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end

### Multi Search using SQL
class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "title ILIKE :query OR synopsis ILIKE :query"
      @movies = Movie.where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end

### Searching through association - Joins
class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = " \
        movies.title ILIKE :query \
        OR movies.synopsis ILIKE :query \
        OR directors.first_name ILIKE :query \
        OR directors.last_name ILIKE :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end

### @@
class MoviesController < ApplicationController
  def index
    if params[:query].present?
      sql_query = " \
        movies.title @@ :query \
        OR movies.synopsis @@ :query \
        OR directors.first_name @@ :query \
        OR directors.last_name @@ :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end

#### PG SEARCH ####
class Movie < ApplicationRecord
  # [...]
  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis,
    against: [ :title, :synopsis ],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end

# rails c
Movie.search_by_title_and_synopsis("superman batm")
### you can weight answers
class NewsArticle < ActiveRecord::Base
  include PgSearch::Model
  pg_search_scope :search_full_text, against: {
    title: 'A',
    subtitle: 'B',
    content: 'C'
  }
end
### more

class Movie < ApplicationRecord
  belongs_to :director
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :synopsis ],
  associated_against: {
    director: [ :first_name, :last_name ]
  },
  using: {
    tsearch: { prefix: true }
  }
end

### setup for TV Shows ###

rails g pg_search:migration:multisearch
rails db:migrate

class Movie < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
end

class TvShow < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
end

# rails c
PgSearch::Multisearch.rebuild(Movie)
PgSearch::Multisearch.rebuild(TvShow)
results = PgSearch.multisearch('superman')

results.each do |result|
  puts result.searchable
  ## searchable is an array full of movies and tv shows
  ## presents in a usable ruby object
end

## in controller post PG install
class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = Movie.global_search(params[:query])
      ##
      @movies = Movie.all if @movies.empty?
    else
      @movies = Movie.all
    end
  end
end

#1: Elasticsearch
# https://www.linuxuprising.com/2019/06/new-oracle-java-11-installer-for-ubuntu.html

## install =>
https://kitt.lewagon.com/knowledge/tutorials/elasticsearch_ubuntu

heroku addons:create bonsai
heroku config:set ELASTICSEARCH_URL=`heroku config:get BONSAI_URL`

# https://github.com/ankane/searchkick

# Gemfile
gem 'searchkick', '~> 4.0'
bundle install


# app/models/movie.rb
class Movie < ApplicationRecord
  searchkick
  # [...]
end

# Launch a `rails c`
Movie.reindex
results = Movie.search("superman")

results.size
results.any?
results.each do |result|
  # [...]
end

## Algolia
#
#
