require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  def setup
    @article = articles(:orange)
  end

  test "should redirect create when not signed in" do
    assert_no_difference 'article.count' do
      article :create, article: { text_content: "Lorem ipsum" }
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'article.count' do
      delete :destroy, id: @article
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy for wrong article" do
    sign_in_as(users(:robert))
    article = articles(:orange)
    assert_no_difference 'article.count' do
      delete :destroy, id: article
    end
    assert_redirected_to root_url
  end
end
