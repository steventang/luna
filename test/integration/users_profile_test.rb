require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:steven)
  end

  test "profile display" do
    get user_path(@user)
    assert_select 'title', full_title(@user.username)
    assert_match @user.username, response.body
    assert_match @user.posts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.text_content, response.body
    end
  end
end
