class UsersController < ApplicationController
  before_action :authenticate_user, only: [:give_award]


  def give_award
    user = params[:id]
    current_user.give(user)
    redirect_to controller: :awards_controller, action: :create
  end

end
