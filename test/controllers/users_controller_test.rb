require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:steven)
    @other_user = users(:robert)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, :id => @user # this automatically uses @user.id
    assert_redirected_to signin_url
  end

  test "should redirect update when not logged in" do
    patch :update, :id => @user, :user => { :username => @user.username, :email => @user.email }
    assert_redirected_to signin_url
  end

  test "should redirect edit when logged in as wrong user" do
    sign_in_as(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    sign_in_as(@other_user)
    patch :update, id: @user, user: { username: @user.username, email: @user.email }
    assert_redirected_to root_url
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    sign_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

end
