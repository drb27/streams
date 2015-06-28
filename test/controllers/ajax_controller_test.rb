require 'test_helper'

class AjaxControllerTest < ActionController::TestCase
  test "should get dispatch" do
    get :dispatch
    assert_response :success
  end

end
