require "test_helper"

class HotelTest < ActiveSupport::TestCase

  test "should not be saved without valid attributes" do
    hotel = Hotel.new
    assert_not hotel.save, "Saved hotel without valid attributes"
  end

end
