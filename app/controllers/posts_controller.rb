class PostsController < ApplicationController
	before_action :signed_in_user, :only => [:new, :create, :destroy]
	before_action :correct_user, :only => [:destroy]

	def new
		@post = current_user.posts.build if signed_in?
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def destroy
		@post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
	end

	def tags
		@tag = params[:tag].downcase
		@article_feed_items = Post.tagged_with(@tag).paginate(page: params[:page], per_page: 20)
	end

	private

		def post_params
			params.require(:post).permit(:title, :text_content, :bootsy_image_gallery_id, :tag_list)
		end

		def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
