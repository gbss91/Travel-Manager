#This test the user flows for an admin
# The admin should be able to see a list of all users, view their profiles and create and edit users

require "test_helper"

class AdminsFlowTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin) #Admin user
    @staff = users(:staff)

  end

  test "show all users" do

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

  test "add new user as administrator" do

    #Admin sign in and goes to new user view
    sign_in @admin
    get new_user_path
    assert_response :success
    assert_select "h1", "Add User" #Check view is rendered

    #Admin adds new user and it's redirect to user list
    post "/users", params: {user: {first_name: "Laura", last_name: "Smith", email: "laura@test.com", admin: true, travel_limit: 2000, password: "123456", password_confirmation: "123456" }}
    assert_response :redirect
    follow_redirect!

    #Check user is displayed
    assert_select "tr", 4
    assert_select "td", "Laura"

  end

  #Delete user
  test "delete user" do

    #Admin sign in and goes user list
    sign_in @admin
    get users_path
    assert_response :success

    #Click delete button and confirm
    delete "/users/#{@staff.id}"

    #User list change -1
    assert_select "tr", 2
  end

  test "see all bookings list" do

    #Admin sign in and goes user list
    sign_in @admin
    get bookings_path
    assert_response :success

    #Displaye user list
    assert_select "tr", 4

  end


end
