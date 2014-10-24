require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:steven) # comes from fixtures
	end

  test "sign in with invalid information" do
  	get signin_path
  	assert_template 'sessions/new'
  	post signin_path, :session => { :email => "", :password => "" }
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?
  end

  test "sign in with valid information followed by sign out" do
  	get signin_path
  	post signin_path, :session => { :email => @user.email, :password => 'password' }
    assert is_signed_in?
  	# no way to get user.password, so we convention that password is always 'password'
  	assert_redirected_to @user
  	follow_redirect! # actually visite the redirect above instead of just verifying it
  	assert_select "a[href=?]", signin_path, :count => 0 # assert that there is no signin link
  	assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
    delete signout_path
    assert_not is_signed_in?
    assert_redirected_to root_url
    # Simulate a user clicking signout in a second window.
    delete signout_path
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
   end
end
