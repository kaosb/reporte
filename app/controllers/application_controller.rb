class ApplicationController < ActionController::Base
	#protect_from_forgery
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def require_valid_user
		if session[:user_id] == nil
			redirect_to login_path
		end
	end
end