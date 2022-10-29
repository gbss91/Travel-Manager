require "test_helper"

class FlightsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @flight = flights(:one)
    @user = users(:admin) #Admin user
    @booking = bookings(:one)
  end

  test "should get index" do
    sign_in @user #Sign in user 
    get booking_flights_path(@booking)
    assert_response :success
  end

  test "should get new" do
    sign_in @user #Sign in user 
    get new_booking_flight_path(@booking)
    assert_response :success
  end

  test "should create flight" do
    sign_in @user #Sign in user 
    assert_difference("Flight.count") do
      post booking_flights_path(@booking), params: { flight: { adults: @flight.adults, arrival_time: @flight.arrival_time, carrier: @flight.carrier, currency: @flight.currency, departure_time: @flight.departure_time, destination_city: @flight.destination_city, duration: @flight.duration, flight_no: @flight.flight_no, origin_city: @flight.origin_city, total_price: @flight.total_price } }
    end

    assert_redirected_to flight_url(Flight.last)
  end

  test "should show flight" do
    sign_in @user
    get flight_url(@flight)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user #Sign in user 
    get edit_flight_url(@flight)
    assert_response :success
  end

  test "should update flight" do
    sign_in @user #Sign in user 
    patch flight_url(@flight), params: { flight: { adults: @flight.adults, arrival_time: @flight.arrival_time, carrier: @flight.carrier, currency: @flight.currency, departure_time: @flight.departure_time, destination_city: @flight.destination_city, duration: @flight.duration, flight_no: @flight.flight_no, origin_city: @flight.origin_city, total_price: @flight.total_price } }
    assert_redirected_to flight_url(@flight)
  end

  test "should destroy flight" do
    sign_in @user #Sign in user 
    assert_difference("Flight.count", -1) do
      delete flight_url(@flight)
    end

    assert_redirected_to flights_url
  end
end
