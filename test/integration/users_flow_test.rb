# This test the different user flows for the user is currently log in (Staff or Admin)
# The current_user should be able to view their profile, edit their details and update password

require "test_helper"

class UsersFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @staff = users(:staff) # Staff user
    @booking = bookings(:two)
  end

  test "show user profile" do
    # User signs in and goes to their profile route
    sign_in @staff
    get "/users/#{@staff.id}"
    assert_response :success

    # Profile is rendered - check user email is rendered
    assert_select "p", @staff.email
  end

  test "edit user profile" do
    # User signs in and goes to their profile route
    sign_in @staff
    get "/users/#{@staff.id}"
    assert_response :success

    # User clicks edit and the form is rendered
    get edit_user_registration_path
    assert_response :success
  end

  test "restrict non-admin to only their profile" do
    # User signs in and goes to their profile route
    sign_in @staff
    get "/users/1"

    # Check name matches staff name
    assert_select "p", @staff.first_name
  end

  test "user can see their bookings" do
    # User signs in and goes to their bookings
    sign_in @staff
    get my_bookings_url
    assert_response :success

    # Display user bookings
    assert_select "h1", "My Bookings"
  end

  test "user deletes own booking" do
    # User signs in and goes to their bookings
    sign_in @staff
    get my_bookings_url
    assert_response :success

    # User selects the booking they want to delete and booking displays
    get booking_url(@booking)
    assert_select "h1", 1, @booking.destination

    # Delete booking
    assert_difference("Booking.count", -1) do
      delete booking_url(@booking)
    end

    # Redirect user to bookings
    assert_response :redirect
    follow_redirect!
    assert_select "h1", "My Bookings"
  end

  test "see(show) booking details" do
    # User signs in and goes to their bookings
    sign_in @staff
    get my_bookings_url
    assert_response :success

    # User opens one of the bookings to see more details
    get booking_url(@booking)
    assert_response :success

    # Booking displays
    assert_select "h1", @booking.destination
  end

  test "staff cannot access other user bookings" do
    # User signs in and tries to open another user booking /bookings/1
    sign_in @staff
    get booking_url(bookings(:one)) # booking one belongs to admin

    # User is redirected to own bookings
    follow_redirect!
    assert_select "h1", "My Bookings"
  end
end
