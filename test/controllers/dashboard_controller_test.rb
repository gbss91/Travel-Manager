require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin) #Admin user
  end

  test "should get main" do
    sign_in @user
    get root_path
    assert_response :success
  end

end
