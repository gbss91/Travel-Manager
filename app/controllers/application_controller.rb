class ApplicationController < ActionController::Base
  before_action :authenticate_user! #Avoid users from accessing controllers without authentication
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_decorator

  protected

  #Set user decorator before at application level
  def set_user_decorator
    @user_decorator = helpers.decorate(current_user)
  end

  #Set admin

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
  
end
