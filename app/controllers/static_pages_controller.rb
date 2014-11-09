class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      # @feed = current_user.feed.paginate(page: params[:page], per_page: 10)
  	  @article_feed_items = current_user.article_feed.paginate(page: params[:article_feed_page], per_page: 20)
      @art_feed_items = current_user.art_feed.paginate(page: params[:art_feed_page], per_page: 20)
	 	else
  		@article_feed_items = default_article_feed.paginate(page: params[:article_feed_page], per_page: 20)
      @art_feed_items = default_art_feed.paginate(page: params[:art_feed_page], per_page: 20)
    end
  end

  def about
  end

  private
	  def default_article_feed
	  	Article.all
	  end 

    def default_art_feed
      Art.all
    end
end
