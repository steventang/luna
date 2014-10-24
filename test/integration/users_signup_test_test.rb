require 'test_helper'

class UsersSignupTestTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
    get signup_path
    name  = "Example User"
    email = "user@example.com"
    password = "password"
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  name,
                                            email: email,
                                            password: password}
    end
    assert_template 'users/show'
    assert is_signed_in?
  end
end
