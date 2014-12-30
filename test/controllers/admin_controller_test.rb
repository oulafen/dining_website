require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get admin_index" do
    get :admin_index
    assert_response :success
  end

end
