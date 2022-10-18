require "test_helper"

class UserTest < ActiveSupport::TestCase

    test "should not user without name" do
        user = User.new
        user.email = "test@test.com"
        assert_not user.save, "Saved the user without a name"
      end
    
      test "should not user without email" do
        user = User.new
        assert_not user.save, "Saved the user without a email"
      end
  
end
