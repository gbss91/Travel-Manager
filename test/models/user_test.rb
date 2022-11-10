# User Model unit testing

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without first and last name" do
    user = User.new
    user.email = "test@test.com"
    assert_not user.save, "Saved the user without a name"
  end

  test "should not user without email" do
    user = User.new # Create  user without email
    assert_not user.save, "Saved the user without a email"
  end
end
