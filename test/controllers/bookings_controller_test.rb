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

  test "should get new" do
    get new_booking_url
    assert_response :success
  end

  test "should create booking" do
    assert_difference("Booking.count") do
      post bookings_url, params: { booking: { booked_on: @booking.booked_on_date, booking_id: @booking.booking_id, currency: @booking.currency, destination: @booking.destination, status: @booking.status, total_price: @booking.total_price, trip_date: @booking.trip_date, user_id: @booking.user_id } }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_url(@booking)
    assert_response :success
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { booked_on: @booking.booked_on, booking_id: @booking.booking_id, currency: @booking.currency, destination: @booking.destination, status: @booking.status, total_price: @booking.total_price, trip_date: @booking.trip_date, user_id: @booking.user_id } }
    assert_redirected_to booking_url(@booking)
  end

  test "should destroy booking" do
    assert_difference("Booking.count", -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
