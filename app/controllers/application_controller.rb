class ApplicationController < ActionController::Base
  before_action :authenticate_user! #Authenticate user before accessing controllers
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_decorator

  protected

  #Initialise user decorator, only if signed in to avoid error
  def set_user_decorator
    if user_signed_in?
      @user_decorator = helpers.decorate(current_user)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
  
end
