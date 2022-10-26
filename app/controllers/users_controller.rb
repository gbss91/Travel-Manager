class UsersController < ApplicationController
  before_action :is_admin, except: :show
  
  # GET all /users - Allows to sort table by params
  def index
    @users = User.order(params[:sort])
  end

  # GET /users/1 - Restrict non-admins to only seeing their own profile
  def show
    current_user.admin ? @user = User.find(params[:id]) : @user = User.find(current_user.id)
  end


  private
  #Check if user is admin before performing actions
  def is_admin
    redirect_to root_path unless current_user.admin?
  end
  
end
