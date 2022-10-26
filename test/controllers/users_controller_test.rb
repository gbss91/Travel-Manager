#Functional testing for Users controller
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do 
    @admin = users(:admin) #Admin user 
  end


  test "should get index" do
    sign_in @admin 
    get users_path
    assert_response :success
  end

  test "should get profile" do
    sign_in @admin
    get "/users/#{@admin.id}"
    assert_response :success
  end

  test "should ask unauthenticated user to sign in" do
    get users_path
    assert_redirected_to new_user_session_path
  end

end
