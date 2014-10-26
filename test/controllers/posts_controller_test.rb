require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @post = posts(:orange)
  end

  test "should redirect create when not signed in" do
    assert_no_difference 'Post.count' do
      post :create, post: { text_content: "Lorem ipsum" }
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'Post.count' do
      delete :destroy, id: @post
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy for wrong post" do
    sign_in_as(users(:robert))
    post = posts(:orange)
    assert_no_difference 'post.count' do
      delete :destroy, id: post
    end
    assert_redirected_to root_url
  end
end
