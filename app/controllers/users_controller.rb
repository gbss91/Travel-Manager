# User controller - Handles actions inside admin panel, allowing users to add and edit other users.
class UsersController < ApplicationController
  before_action :admin?, except: :show
  before_action :set_user, only: %i[show edit update destroy]

  # GET all /users - Allows to sort table by params
  def index
    @users = params[:search].present? ?  MySearch.user(%w[id first_name last_name email], params[:search]) : User.order(params[:sort])
  end

  # GET /users/1 - Restrict non-admins to only seeing their own profile
  def show
    current_user.admin ? @user : @user = User.find(current_user.id)
  end

  # GET /users/1/edit
  def edit; end

  # GET /user/new
  def new
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.includes(:bookings).find(params[:id])
  end

  # Check if user is admin before performing actions
  def admin?
    redirect_to root_path unless current_user.admin?
  end

  # This params are used in admin panel
  # Params used to create new users outside admin panel are handled by Devise controller
  # Added this to brakeman ignore file
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :admin, :password, :password_confirmation)
  end
end
