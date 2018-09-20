class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :all_givers, :all_givings]

  #before_action :set_user, only: [:show_givers, :show_givings]

  def show
    @user = User.find(params[:id])
  end

  def current_user_show
    @my_awards = current_user.awards
  end

  def all_givers
    @given_awards = current_user.given_awards
  end

  def all_givings
    @giving_awards = current_user.giving_awards
  end



end

