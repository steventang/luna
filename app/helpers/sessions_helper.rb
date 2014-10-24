module SessionsHelper

	def sign_in(user)
		session[:user_id] = user.id
	end

	# remember user in persistent session via cookies
	def remember(user)
		user.remember # store a hashed remember token in the db
		cookies.permanent.signed[:user_id] = user.id # signed here to keep secure
		cookies.permanent[:remember_token] = user.remember_token
	end

	def current_user
		if (user_id = session[:user_id]) # If session of user id exists (while setting user id to session of user id)
      @current_user ||= User.find_by(id: user_id) # dont use User.find it raises exception if User nil
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        sign_in user
        @current_user = user
      end
    end
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def forget(user)
  	user.forget
  	cookies.delete(:user_id)
  	cookies.delete(:remember_token)
  end

end
