require "application_system_test_case"

class FlightsTest < ApplicationSystemTestCase
  setup do
    @flight = flights(:one)
  end

  test "visiting the index" do
    visit flights_url
    assert_selector "h1", text: "Flights"
  end

  test "should create flight" do
    visit flights_url
    click_on "New flight"

    fill_in "Adults", with: @flight.adults
    fill_in "Arrival time", with: @flight.arrival_time
    fill_in "Carrier", with: @flight.carrier
    fill_in "Currency", with: @flight.currency
    fill_in "Departure time", with: @flight.departure_time
    fill_in "Destination city", with: @flight.destination_city
    fill_in "Duration", with: @flight.duration
    fill_in "Flight no", with: @flight.flight_no
    fill_in "Origin city", with: @flight.origin_city
    fill_in "Total price", with: @flight.total_price
    click_on "Create Flight"

    assert_text "Flight was successfully created"
    click_on "Back"
  end

  test "should update Flight" do
    visit flight_url(@flight)
    click_on "Edit this flight", match: :first

    fill_in "Adults", with: @flight.adults
    fill_in "Arrival time", with: @flight.arrival_time
    fill_in "Carrier", with: @flight.carrier
    fill_in "Currency", with: @flight.currency
    fill_in "Departure time", with: @flight.departure_time
    fill_in "Destination city", with: @flight.destination_city
    fill_in "Duration", with: @flight.duration
    fill_in "Flight no", with: @flight.flight_no
    fill_in "Origin city", with: @flight.origin_city
    fill_in "Total price", with: @flight.total_price
    click_on "Update Flight"

    assert_text "Flight was successfully updated"
    click_on "Back"
  end

  test "should destroy Flight" do
    visit flight_url(@flight)
    click_on "Destroy this flight", match: :first

    assert_text "Flight was successfully destroyed"
  end
end
