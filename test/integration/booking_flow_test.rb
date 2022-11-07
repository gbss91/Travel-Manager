require "test_helper"

class BookingFlowTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @staff = users(:staff) #Staff user
    @booking = bookings(:two)
    @flight = flights(:flight_two)
    @hotel= hotels(:two)
    sign_in @staff #Assume user is signed in for all tests
  end

  test "book a one way trip" do

    #User goes to New Booking
    get search_url
    assert_response :success

    #When clicking search, booking is created and user is redirected to flight results
    get booking_flights_outbound_url(@booking)
    assert_response :success
    assert_select "h1", 1, "Outbound"

    #User selects flight and flight is created
    assert_difference("Flight.count") do
      post booking_flights_path(@booking), params: { adults: @flight.adults, arrival_time: @flight.arrival_time, carrier: @flight.carrier, departure_time: @flight.departure_time, destination_city: @flight.destination_city, duration: @flight.duration, flight_no: @flight.flight_no, origin_city: @flight.origin_city, total_price: @flight.total_price }
    end

    #User is redirected to hotel results
    assert_response :redirect
    assert_redirected_to booking_hotels_results_url(@booking)
    follow_redirect!
    assert_select "h1", 1, "Hotels"

    #User selects hotel and hotel is created


    #User is redirected to booking preview

    #User clicks confirm and the booking is updated to Completed





  end

end