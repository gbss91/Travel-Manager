#This test the different user flows for the user is currently log in (Staff or Admin)
# The current_user should be able to view their profile, edit their details and update password

require "test_helper"

class UsersFlowTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @staff = users(:staff) #Staff user
  end

  test "show user profile" do

    #User signs in and goes to their profile route
    sign_in @staff
    get "/users/#{@staff.id}"
    assert_response :success

    #Profile is rendered - check user email is rendered
    assert_select "p", @staff.email

  end

  test "edit user profile" do

    #User signs in and goes to their profile route
    sign_in @staff
    get "/users/#{@staff.id}"
    assert_response :success

    #User clicks edit and the form is rendered
    get edit_user_registration_path
    assert_response :success

  end

  test "restrict non-admin to only their profile" do

    #User signs in and goes to their profile route
    sign_in @staff
    get "/users/1"

    #Check name matches staff name
    assert_select "p", @staff.first_name

  end

  test "see my bookings" do

    #User signs in and goes to their bookings
    sign_in @staff
    get my_bookings_url
    assert_response :success

    #Display user bookings
    assert_select "h5", "New York"
  end

end
