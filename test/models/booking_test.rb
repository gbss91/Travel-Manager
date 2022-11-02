require "test_helper"

class BookingTest < ActiveSupport::TestCase

  test "should not save without valid attributes" do
    booking = Booking.new
    assert_not booking.save, "Saved without valid attributes"
  end

end
