class UsersController < ApplicationController
  before_action :authenticate_user, only: [:all_givers, :all_givings]
  #before_action :set_user, only: [:show_givers, :show_givings]
  def all_givers
    @given_awards = current_user.given_awards
  end

  def all_givings
    @giving_awards = current_user.giving_awards
  end

  #<% @given_awards.each do |ga| %>
   # <%= ga.given.username %>
  #<% end %>
 # view側では上の書き方で呼び出せる




end
