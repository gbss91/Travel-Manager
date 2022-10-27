#This test the user flows for an admin
# The admin should be able to see a list of all users, view their profiles and create and edit users

require "test_helper"

class AdminsFlowTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin) #Admin user
    @staff = users(:staff)

  end

  test "show all users for admin" do

    #Administrator signs in and goes to Users
    sign_in @admin
    get users_path
    assert_response :success

    #List of users is rendered
    # #There should be 3 rows (title and each user in fixture
    assert_select "tr", 3

  end

  test "view other user profile" do

    #Admin signs in and goes to staff profile
    sign_in @admin
    get "/users/#{@staff.id}"

    #Profile is rendered - check user email is rendered
    assert_select "p", @staff.email
  end

end
