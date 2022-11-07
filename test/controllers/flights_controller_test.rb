require "test_helper"

class FlightsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @flight = flights(:flight_one)
    @user = users(:admin) #Admin user
    @booking = bookings(:one)
  end

  test "should get outbound" do
    sign_in @user
    get booking_flights_outbound_url(@booking)
    assert_response :success
  end

  test "should get inbound" do
    sign_in @user
    get booking_flights_inbound_url(@booking)
    assert_response :success
  end

  test "should create flight" do
    sign_in @user #Sign in user 
    assert_difference("Flight.count") do
      post booking_flights_path(@booking), params: { adults: @flight.adults, arrival_time: @flight.arrival_time, carrier: @flight.carrier, departure_time: @flight.departure_time, destination_city: @flight.destination_city, duration: @flight.duration, flight_no: @flight.flight_no, origin_city: @flight.origin_city, total_price: @flight.total_price }
    end
  end

end
