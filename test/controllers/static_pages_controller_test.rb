require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
  	@article_feed_items = []
  	@art_feed_itmes = []
    get :home
    assert_response :success
  end

end
