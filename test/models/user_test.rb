require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "example", email: "user@example.com",
                     password: "foobar")
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated articles should be destroyed" do
    @user.save
    @user.articles.create!(title: "Lorem", text_content: "Lorem ipsum")
    assert_difference 'Article.count', -1 do
      @user.destroy
    end
  end

end
