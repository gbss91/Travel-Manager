# Test dashboard. Correct dashboard should be displayed according to user role

require "test_helper"
class DashboardFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = users(:admin)
    @staff = users(:staff)
  end

  test "Show admin menu when admin signs in" do
    # Admin signs in and is redirected to dashboard
    sign_in @admin
    get "/"
    assert_select "title", "Travel Manager Dashboard"

    # Renders admin side menu
    assert_select "h5", "John Smith", 1 # Name in fixture
  end

  test "Show staff menu when staff signs in" do
    # Staff signs in and is redirected to dashboard
    sign_in @staff
    get "/"
    assert_select "title", "Travel Manager Dashboard"

    # Renders staff menu
    assert_select "h5", "Rebecca Gonzalez", 1
  end
end
