require "test_helper"

class BookingTest < ActiveSupport::TestCase

  test "should not be saved without valid attributes" do
    booking = Booking.new
    assert_not booking.save, "Saved hotel without valid attributes"
  end

end
