require "test_helper"

class BookingTest < ActiveSupport::TestCase

  test "should not save without valid attributes" do
    booking = Booking.new
    assert_not booking.save, "Saved without valid attributes"
  end

  test "custom base validation error" do
    booking = Booking.new
    booking.save
    assert booking.errors.include?(:base)
  end

end
