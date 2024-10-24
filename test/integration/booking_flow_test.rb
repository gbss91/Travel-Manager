require "test_helper"

class BookingFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @hotel = hotels(:hotel_two)
    @staff = users(:staff) # Staff
    @booking = bookings(:three)
    @flight = flights(:flight_two)
    sign_in @staff # Assume user is signed in for all tests
  end

  test "user books a one way flight" do
    # User goes to New Booking
    get search_url
    assert_response :success

    # When clicking search, booking is created and user is redirected to outbound flights
    get booking_flights_outbound_url(@booking)
    assert_response :success

    # User selects flight and flight is created

    post booking_flights_path(@booking), params: { flight: { adults: @flight.adults, arrival_time: @flight.arrival_time, carrier: @flight.carrier, carrier_code: @flight.carrier_code, departure_time: @flight.departure_time, destination_city: @flight.destination_city, duration: @flight.duration, flight_no: @flight.flight_no, origin_city: @flight.origin_city, total_price: @flight.total_price, booking_id: @booking.id, direction: @flight.direction } }

    # User is redirected to hotel results as this is a one way trip
    assert_response :redirect
    assert_redirected_to booking_hotels_results_url(@booking)
    follow_redirect!
    assert_select "h1", 1, "Hotels"
  end

  test "user selects hotel and confirm booking" do
    # User selects hotel and hotel is created
    post booking_hotels_path(@booking), params: { hotel: { booking_id: @booking.id, hotel_name: @hotel.hotel_name, address: @hotel.address, room_type: @hotel.room_type, rate: @hotel.rate } }

    assert_response :redirect

    # User is redirected to booking preview
    assert_response :redirect
    assert_redirected_to confirm_booking_url(@booking)
    follow_redirect!
    assert_select "h1", 1, @booking.destination

    # User clicks confirm and the booking is updated to Confirmed
    put booking_path(@booking), params: { booking: { status: "Confirmed" } }

    # User is redirected to booking
    assert_response :redirect
    assert_redirected_to booking_url(@booking)
  end
end
