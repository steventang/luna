require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:steven)
  end

  test "unsuccessful edit" do
    sign_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), user: { username: '',
                                    email: 'foo@invalid',
                                    password: 'foo'}
    assert_template 'users/edit'
  end

  test "successful edit with friendly fowarding" do
    get edit_user_path(@user) # attempt to visit editing without signing in
    sign_in_as(@user)
    assert_redirected_to edit_user_path(@user) # verify that we friendly fowarded
    get edit_user_path(@user)
    username  = "steventang"
    email = "steven@example.com"
    patch user_path(@user), user: { username: username,
                                    email: email,
                                    password: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.username, username
    assert_equal @user.email, email
  end
end
