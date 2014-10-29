class ArtsController < ApplicationController
	before_action :signed_in_user, :only => [:new, :create, :destroy]
	before_action :correct_user, :only => [:destroy]

  def new
		@art = current_user.arts.build if signed_in?
	end

	def create
		@art = current_user.arts.build(art_params)
		if @art.save
			flash[:success] = "Art uploaded!"
			redirect_to @art
		else
			render 'new'
		end
	end

	def show
		@art = Art.find(params[:id])
	end

	def destroy
		@art.destroy
    flash[:success] = "Art deleted"
    redirect_to request.referrer || root_url
	end

	private

		def art_params
			params.require(:art).permit(:title, :picture, :description)
		end

		def correct_user
      @art = current_user.arts.find_by(id: params[:id])
      redirect_to root_url if @art.nil?
    end
end
