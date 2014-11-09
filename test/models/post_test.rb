require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:steven)
    # This code is not idiomatically correct.
    @article = @user.articles.build(text_content: "Lorem ipsum")
  end

  test "article should be valid" do
    assert @article.valid?
  end

  test "user id should be present" do
    @article.user_id = nil
    assert_not @article.valid?
  end

  test "order should be most recent first" do
    assert_equal Article.first, articles(:most_recent)
  end

  test "text_content should be present " do
    @article.text_content = " "
    assert_not @article.valid?
  end	
end
