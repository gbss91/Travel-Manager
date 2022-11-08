require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @booking = bookings(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get bookings_path
    assert_response :success
  end

  test "should get current_user_bookings" do
    get my_bookings_url
    assert_response :success
  end

  test "should get new" do
    get search_url
    assert_response :success
  end

  test "should create booking" do
    assert_difference("Booking.count") do
      post bookings_url, params: { booking: {user_id: @booking.user_id, booked_on_date: @booking.booked_on_date, origin: @booking.origin, destination: @booking.destination, departure_date: @booking.departure_date, return_date: @booking.return_date, adults: @booking.adults, status: @booking.status, booking_type: @booking.booking_type } }
    end

    assert_redirected_to booking_flights_outbound_path(Booking.last)
  end

  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should get confirm" do
    get confirm_booking_url(@booking)
    assert_response :success
  end


  test "should destroy booking" do
    assert_difference("Booking.count", -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
