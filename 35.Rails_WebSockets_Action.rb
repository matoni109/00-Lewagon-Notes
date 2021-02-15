## web sockets for the WIN!!
#
#  { initChatroomCable }; => add to tubolinks!!
# import into application.js !!
# make with devise
#
# https://guides.rubyonrails.org/action_cable_overview.html
# https://kitt.lewagon.com/knowledge/cheatsheets/actioncable

rails g migration AddNicknameToUsers nickname
rails g model Chatroom name
rails g model Message content chatroom: references, user: references
rails db: migrate

class Chatroom < ApplicationRecord
  has_many :messages
end

class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
end

rails c
Chatroom.create(name: 'general')
User.create(email: 'seb@lewagon.org', nickname: 'ssaunier', password: '123456')
User.create(email: 'boris@lewagon.org', nickname: 'Papillard', password: '123456')

rails g controller chatrooms
rails g controller messages

# config/routes.rb
resources :chatrooms, only: :show do
  resources :messages, only: :create # need to nest to find chatroom
end

# app/controllers/chatrooms_controller.rb
class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
  end
end

# <!-- app/views/chatrooms/show.html.erb -->


<h1>#<%= @chatroom.name %></h1>
<div id="messages" data-chatroom-id="<%= @chatroom.id %>">
  <% @chatroom.messages.each do |message| %>
    <div class="message-container" id="message-<%= message.id %>">
      <i class="author">
        <span><%= message.user.nickname %></span>
        <small><%= message.created_at.strftime("%a %b %e at %l:%M%p") %></small>
      </i>
      <p><%= message.content %></p>
    </div>
  <% end %>
</div>
#=>
# open 2 browsers with localhost:3000/chatrooms/1

<!-- app/views/chatrooms/show.html.erb -->
<!-- [...] -->

<%= simple_form_for [ @chatroom, @message ], remote: true do |f| %>
  <%= f.input :content, label: false, placeholder: "Message ##{@chatroom.name}" %>
<% end %>
#=>

# app/controllers/messages_controller.rb
def create
  @chatroom = Chatroom.find(params[:chatroom_id])
  @message = Message.new(message_params)
  @message.chatroom = @chatroom
  @message.user = current_user

  if @message.save
## send to the channel
    ChatroomChannel.broadcast_to(
  @chatroom,
  # need to make _message partial in the view
  render_to_string(partial: "message", locals: { message: @message })
)


    redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
  else
    render 'chatrooms/show'
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

## add action cable ::
rails g channel Chatroom

class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom # "chatroom_1" like a link_to
  end

def unsubscribed
  # any cleanup cheeded when channel is closed
end

end

# // app/javascript/channels/chatroom_channel.js
import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        // console.log(data); // called when data is / // broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }
}

export { initChatroomCable }; => add to tubolinks!!

##
## make the partial _message
<!-- app/views/messages/_message.html.erb -->
<div class="message-container" id="message-<%= message.id %>">
  <i class="author">
    <span><%= message.user.nickname %></span>
    <small><%= message.created_at.strftime("%a %b %e at %l:%M%p") %></small>
  </i>
  <p><%= message.content %></p>
</div>

## chatroom show.html.erb
<h1>#<%= @chatroom.name %></h1>
<div id="messages" data-chatroom-id="<%= @chatroom.id %>">
  <% @chatroom.messages.each do |message| %>
       <%= render 'messages/message', message: message %>
   <% end %>
</div>
#=>

### REDIS and heroku
#
#
# config/cable.yml
# [...]

production:
  adapter: redis
  url: <%= ENV.fetch("REDISCLOUD_URL") { "redis://localhost:6379/1" } %>
  channel_prefix: slack_clone_production


#=> heroku addons:create rediscloud:30

Full solution

lewagon/rails-action-cable-chat

Notifications, posts, comments...

