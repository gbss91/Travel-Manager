require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should get pricing" do
    get home_pricing_path
    assert_response :success
  end
end
