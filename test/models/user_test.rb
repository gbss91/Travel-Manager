#User Model unit testing 

require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do 
    @user1 = users(:admin) #Admin 
    @user2 = users(:admin) #Second user with same details as user1
  end

    test "should not save user without name" do
        user = User.new
        user.email = "test@test.com"
        assert_not user.save, "Saved the user without a name"
      end
    
      test "should not user without email" do
        user = User.new #Create  user without email
        assert_not user.save, "Saved the user without a email"
      end
  
end
