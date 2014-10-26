require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:steven)
  end

  test "post interface" do
    sign_in_as(@user)
    get new_post_path
    assert_select 'div.pagination'
    # Invalid submission
    post posts_path, post: { text_content: "" }
    assert_select 'div#error_explanation'
    # Valid submission
    text_content = "This post really ties the room together"
    assert_difference 'Post.count', 1 do
      post posts_path, post: { text_content: text_content }
    end
    follow_redirect!
    assert_match text_content, response.body
    # Delete a post.
    assert_select 'a', 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit a different user.
    get user_path(users(:robert))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end