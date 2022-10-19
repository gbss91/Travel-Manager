#Functional testing for home controller 

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should get pricing" do
    get pricing_path
    assert_response :success
  end
end
