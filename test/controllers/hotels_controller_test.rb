require "test_helper"

class HotelsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @hotel = hotels(:one)
    @staff = users(:staff) #Staff
    @admin = users(:admin) #Admin
    @booking = bookings(:one)
  end

  test "should get results" do
    sign_in @staff
    get booking_hotels_results_url(@booking)
    assert_response :success
  end

  test "should create hotel" do
    assert_difference("Hotel.count") do
      post booking_hotels_url(@booking), params: {hotel_name: @hotel.hotel_name, address: @hotel.address, room_type: @hotel.room_type, rate: @hotel.rate}
    end

    assert_redirected_to booking_url
  end

  test "should destroy hotel" do
    assert_difference("Hotel.count", -1) do
      delete booking_hotel_url(@hotel)
    end
  end
end
