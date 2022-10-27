require "test_helper"

class FlightTest < ActiveSupport::TestCase

  test "should not save without valid attributes" do
    flight = Flight.new
    assert_not flight.save, "Saved without valid attributes"
  end
end
