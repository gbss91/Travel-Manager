require "test_helper"

class SignUpAndInFlowTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:admin) #Admin user 
  end

  test "Render sign up view" do
    
    #Show sign up page
    get new_user_registration_path
    assert_response :success

    #Show form title
    assert_select "h3", "Sign up", 1


  end

  test "Sign user in and redirect to dashboard" do

    #Show sign in page
    get new_user_session_path
    assert_response :success

    #Sign user in and redirect to dashboard
    sign_in @user
    assert_select "img", 1

  end

end
