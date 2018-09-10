class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @my_awards = current_user.awards
  end
  #before_action :set_user, only: [:show_givers, :show_givings]
  def show_givers
    user = User.find(4)
    @given_awards = user.given_awards
  end

  def show_givings
    user = User.find(4)
    @giving_awards = user.giving_awards
  end

  #<% @given_awards.each do |ga| %>
   # <%= ga.given.username %>
  #<% end %>
 # view側では上の書き方で呼び出せる

end

