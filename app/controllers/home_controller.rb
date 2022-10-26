class HomeController < ApplicationController
  skip_before_action :authenticate_user! #Allow unauthenticated users to access index and pricing website
  layout "home"
  
  def index
    
  end

  def pricing
    
  end

end
