# Homepage controller
class HomeController < ApplicationController
  # Allow unauthenticated users to access index and pricing website, and skip decorator
  skip_before_action :authenticate_user!
  layout "home"

  def index; end

  def pricing; end
end
