class DashboardController < ApplicationController
  before_action :set_user_decorator
  def main
  end

  private
  #Set user decorator
  def set_user_decorator
    @user_decorator = helpers.decorate(current_user)
  end

end
