class ArticlesController < ApplicationController
	before_action :signed_in_user, :only => [:new, :create, :destroy]
	before_action :correct_user, :only => [:destroy]

	def new
		@article = current_user.articles.build if signed_in?
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "Article created!"
			redirect_to @article
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		@article.destroy
    flash[:success] = "Article deleted"
    redirect_to request.referrer || root_url
	end

	def tags
		@tag = params[:tag].downcase
		@article_feed_items = Article.tagged_with(@tag).paginate(page: params[:page], per_page: 20)
	end

	private

		def article_params
			params.require(:article).permit(:title, :text_content, :bootsy_image_gallery_id, :tag_list)
		end

		def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
end
