class UsersController < ApplicationController
	before_action :signed_in_user, :only => [:index, :edit, :update]
	before_action :correct_user, 	 :only => [:destroy, :edit, :update] # Not 100% sure if this is safe for destroy action. Need to ask someone
	# before_action :admin_user, 		 :only => [:destroy]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		@user.send_welcome_email
  		sign_in @user
  		flash[:success] = "Welcome to our site. You've signed up succesfully"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  	@user = User.friendly.find(params[:id])
  end

  def update
  	@user = User.friendly.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:success] = "Profile updated"
  		redirect_to @user
  	else
  		render 'edit'
  	end
	end  

  def show
  	# .friendly is for friendly_id gem to make better routes
  	@user = User.friendly.find(params[:id])
  	@articles = @user.articles.paginate(:page => params[:page], :per_page => 10)
  end

  def index
  	@users = User.paginate(:page => params[:page])
  end

  def destroy
  	User.friendly.find(params[:id]).destroy 	
		if current_user.admin? # if admin is deleting users from users page, go back to users page
			flash[:success] = "User deleted"
			redirect_to users_url
  	else
  		sign_out
  		flash[:success] = "Your account has been deleted"
  		redirect_to root_url # if user delete themselves, go back to root
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :username, :email, :password)
  	end

  	def correct_user
  		redirect_to root_url unless (current_user?(User.friendly.find(params[:id])) || current_user.admin?)
  	end

  	def admin_user
  		redirect_to root_url unless current_user.admin?
  	end

end