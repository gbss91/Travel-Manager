require "application_system_test_case"

class HotelsTest < ApplicationSystemTestCase
  setup do
    @hotel = hotels(:one)
  end

  test "visiting the index" do
    visit hotels_url
    assert_selector "h1", text: "Hotels"
  end

  test "should create hotel" do
    visit hotels_url
    click_on "New hotel"

    fill_in "Address", with: @hotel.address
    fill_in "Board type", with: @hotel.board_type
    fill_in "Booking", with: @hotel.booking_id
    fill_in "Check in date", with: @hotel.check_in_date
    fill_in "Check in time", with: @hotel.check_in_time
    fill_in "Check out time", with: @hotel.check_out_time
    fill_in "City", with: @hotel.city
    fill_in "Currency", with: @hotel.currency
    fill_in "Hotel brand", with: @hotel.hotel_brand
    fill_in "Hotel name", with: @hotel.hotel_name
    fill_in "No nights", with: @hotel.no_nights
    fill_in "Rate", with: @hotel.rate
    fill_in "Total price", with: @hotel.total_price
    click_on "Create Hotel"

    assert_text "Hotel was successfully created"
    click_on "Back"
  end

  test "should update Hotel" do
    visit hotel_url(@hotel)
    click_on "Edit this hotel", match: :first

    fill_in "Address", with: @hotel.address
    fill_in "Board type", with: @hotel.board_type
    fill_in "Booking", with: @hotel.booking_id
    fill_in "Check in date", with: @hotel.check_in_date
    fill_in "Check in time", with: @hotel.check_in_time
    fill_in "Check out time", with: @hotel.check_out_time
    fill_in "City", with: @hotel.city
    fill_in "Currency", with: @hotel.currency
    fill_in "Hotel brand", with: @hotel.hotel_brand
    fill_in "Hotel name", with: @hotel.hotel_name
    fill_in "No nights", with: @hotel.no_nights
    fill_in "Rate", with: @hotel.rate
    fill_in "Total price", with: @hotel.total_price
    click_on "Update Hotel"

    assert_text "Hotel was successfully updated"
    click_on "Back"
  end

  test "should destroy Hotel" do
    visit hotel_url(@hotel)
    click_on "Destroy this hotel", match: :first

    assert_text "Hotel was successfully destroyed"
  end
end
