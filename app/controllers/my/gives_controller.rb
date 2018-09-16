class My::GivesController < ApplicationController
  before_action :authenticate_user, only: [:all_givers, :all_givings]

  def all_givers
    @given_awards = current_user.given_awards
  end

  def all_givings
    @giving_awards = current_user.giving_awards
  end

end
