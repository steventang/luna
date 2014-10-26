require 'test_helper'

class UsersSignupTestTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username:  "bad.name",
                               email: "user@invalid",
                               password: "foo"}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    username  = "example"
    email = "user@example.com"
    password = "password"
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username:  name,
                                            email: email,
                                            password: password}
    end
    assert_template 'users/show'
    assert is_signed_in?
  end
end
