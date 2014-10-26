require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
  	@feed_items = []
    get :home
    assert_response :success
  end

end
