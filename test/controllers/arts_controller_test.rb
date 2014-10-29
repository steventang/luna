require 'test_helper'

class ArtsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
