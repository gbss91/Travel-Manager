require "test_helper"

class HotelsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @hotel = hotels(:hotel_two)
    @staff = users(:staff) #Staff
    @booking = bookings(:two)
  end

  test "should get results" do
    sign_in @staff
    get booking_hotels_results_url(@booking)
    assert_response :success
  end

  test "should create hotel" do
    sign_in @staff
    assert_difference("Hotel.count") do
      post booking_hotels_path(@booking), params: { hotel: { booking_id: @booking.id, hotel_name: @hotel.hotel_name, address: @hotel.address, room_type: @hotel.room_type, rate: @hotel.rate } }
    end

    assert_redirected_to confirm_booking_url(@booking)
  end


end
