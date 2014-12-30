require 'test_helper'

class MerchantControllerTest < ActionController::TestCase
  test "should get merchant_index" do
    get :merchant_index
    assert_response :success
  end

end
