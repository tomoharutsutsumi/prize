class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @my_awards = current_user.awards
  end

end

