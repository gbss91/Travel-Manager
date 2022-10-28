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

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end


  def update
    respond_to do |format|
      @user = User.find(params[:id])
      if @user.update(user_params)
        format.html { redirect_to users_path }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  #Check if user is admin before performing actions
  def is_admin
    redirect_to root_path unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :admin, :travel_limit)
  end
  
end
