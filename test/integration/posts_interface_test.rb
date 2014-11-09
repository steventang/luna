require 'test_helper'

class ArticleInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:steven)
  end

  test "article interface" do
    sign_in_as(@user)
    get new_article_path
    assert_select 'div.pagination'
    # Invalid submission
    post articles_path, article: { text_content: "" }
    assert_select 'div#error_explanation'
    # Valid submission
    text_content = "This article really ties the room together"
    assert_difference 'Article.count', 1 do
      post articles_path, article: { text_content: text_content }
    end
    follow_redirect!
    assert_match text_content, response.body
    # Delete a article.
    assert_select 'a', 'delete'
    first_article = @user.articles.paginate(page: 1).first
    assert_difference 'Article.count', -1 do
      delete article_path(first_article)
    end
    # Visit a different user.
    get user_path(users(:robert))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end