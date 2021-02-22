##
# Push outside of the controller time-consuming processes.
#
admin gem with Hotwire
# https://github.com/excid3/madmin

# https://edgeguides.rubyonrails.org/active_job_basics.html
##
mailers in rails
# https://kitt.lewagon.com/knowledge/tutorials/mailing

rails g migration AddAdminToUsers

def change
  add_column :users, :admin, :boolean, null: false, default: false
end

#=>

rails generate job fake

# app/jobs/fake_job.rb
class FakeJob < ApplicationJob
  queue_as :default

  def perform
    puts "I'm starting the fake job"
    sleep 3
    puts "OK I'm done now"
  end
end

## run the job
FakeJob.perform_now

## http://sidekiq.org/
# user sidekiq
#
bundle install
bundle binstub sidekiq

# config/application.rb
class Application < Rails::Application
  # [...]
  config.active_job.queue_adapter = :sidekiq
end

# config/routes.rb
Rails.application.routes.draw do
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

# config/sidekiq.yml
:concurrency: 3
:timeout: 60
:verbose: true
:queues:
  # Queue priority:
  # https://github.com/mperham/sidekiq/wiki/Advanced-Options
  # https://mikerogers.io/2019/06/06/rails-6-sidekiq-queues
  - default
  - mailers
  - active_storage_analysis
  - active_storage_purge

##
#
now lets use it
#=>
#=> //
sidekiq
FakeJob.perform_later

now change it

# app/jobs/update_user_job.rb
class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(1)
    puts "Calling Clearbit API for #{user.email}..."
    # TODO: perform a time consuming task like Clearbit's Enrichment API.
    sleep 2
    puts "Done! Enriched #{user.email} with Clearbit"
  end
end

# When a Job is enqueued, the arguments are serialized.

## BEWARE if you use another framework for background jobs (e.g. Sidekiq::Worker), pass ids or strings as arguments, not full objects

user = User.find(1)
user.to_global_id #=> #<GlobalID:0x000055988bc4dd20 [...] gid://background-jobs-demo/User/1>>
user.to_global_id.to_s #=> "gid://background-jobs-demo/User/1"


#
# Enqueue from a model

# app/models/user.rb
class User < ApplicationRecord
  # [...]

  after_commit :async_update # Run on create & update

  private

  def async_update
    UpdateUserJob.perform_later(self)
  end
end

# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  def update
    if current_user.update(user_params)
      ## calls the job in folder
      UpdateUserJob.perform_later(current_user)  # <- The job is queued
      flash[:notice] = "Your profile has been updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    # Some strong params of your choice
  end
end

## que tasks
#
#
rails g task user update_all
# lib/tasks/user.rake
namespace :user do
  desc "Enriching all users with Clearbit (async)"
  task update_all: :environment do
    users = User.all
    puts "Enqueuing update of #{users.size} users..."
    users.each do |user|
      UpdateUserJob.perform_later(user)
    end
    # rake task will return when all jobs are _enqueued_ (not done).
    desc "Enriching a given user with Clearbit (sync)"
  task :update, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    puts "Enriching #{user.email}..."
    UpdateUserJob.perform_now(user)
    # rake task will return when job is _done_
  end
  end
end

# Look, there's a new task!
rails -T | grep user

# We can run it with
rails user:update_all

# Enqueue from a rake task (2)
# Update user of id 42 with this command
noglob rails user:update[42]
#or
rails user:update\[42\]

## MAILERS
# UserMailer.welcome(user).deliver_now

UserMailer.welcome(user_id).deliver_later

##
#
#

FakeJob.set(wait: 1.minute).perform_later

FakeJob.set(wait_until: Date.tomorrow.noon).perform_later


##
heroku addons:create rediscloud

# config/initializers/redis.rb
$redis = Redis.new

url = ENV["REDISCLOUD_URL"]

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(:url => url)
end

##
# Procfile
touch Procfile
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml

## setup in heroku
heroku ps:scale worker=1
heroku ps # Check worker dyno is running

## goto heroku resources
heroku scheduler
run ever *
# https://devcenter.heroku.com/articles/scheduler
