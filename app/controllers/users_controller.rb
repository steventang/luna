class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to our site. You've signed up succesfully"
  		redirect_to @user
  	else
  		render 'new'
  	end

  end

  def update
  end

  def show
  	@user = User.find(params[:id])
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password)
  	end

end
