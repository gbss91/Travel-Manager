class UsersController < ApplicationController
  
  # GET all /users
  def index
    @users = User.all
  end

  # GET /users/1 
  def show 
  end
  
end
