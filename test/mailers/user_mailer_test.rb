require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    
  end

  test "account_creation" do
    # create a new user bc fixtures can't have virtual attributes like activation tokens (if we want to do in future)
    user = User.create(username: "testuser", email: "test@example.com",
                       password: "foobar")
    mail = UserMailer.account_creation(user)
    assert_equal "Thanks for joining ESportsPN!", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:steven)
    user.create_reset_digest
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

end
