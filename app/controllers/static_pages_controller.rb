class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 20)
	 	else
  		@feed_items = default_feed.paginate(:page => params[:page], :per_page => 20)
  	end
  end

  def about
  end

  private
	  def default_feed
	  	Post.all
	  end  
end
