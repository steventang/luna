class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(:email => params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		flash[:success] = "Welcome back!"
  		sign_in user
  		remember user
  		redirect_to user
  	else
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	sign_out if signed_in? # fixes problem of user clicking signing out on multiple tabs
  	redirect_to root_url
  end

end
