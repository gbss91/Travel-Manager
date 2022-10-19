require "test_helper"

class SignUpFlowTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin) #Admin user 
  end

  test "Sign user in and redirect to dashboard" do
    
    #Show sign in page
    get new_user_session_path 
    assert_response :success

    #Sign user in and redirect to dashboard
    sign_in @user 
    assert_redirected_to


    end
end
