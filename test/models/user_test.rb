require "test_helper"

class UserTest < ActiveSupport::TestCase

    test "should not user without name" do
        user = User.new
        user.email = "test@test.com"
        assert_not user.save, "Saved the user without a name"
      end
    
      test "should not user without email" do
        user = User.new #Create second user without email
        assert_not user.save, "Saved the user without a email"
      end

      test "should not save duplicate user" do
        user1 = User.create(email: "test@test.com")
        user2 = User.new(email: "test@test.com") #Create second user with the same details 
        assert_not user2.save, "Saved duplicate user"
      end
  
end
