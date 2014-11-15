class UserController < ApplicationController

	def signup_process
		User.create(user_params)
		redirect_to "/"
	end

	def login_process
		user = User.where(username: params[:username]).first

		if user
			if user.authenticate(params[:password])
				session[:user_id] = user.id
				session[:first_name] = user.first_name
				redirect_to "/"
			else
				render :text => "Nope sorry"
			end
		else
			render :text => "Nope sorry"
		end
	end

	def logout_process
		session[:user_id] = false
		redirect_to "/"
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :first_name, :last_name, :email_address, :city, :state, :user_type)
	end

end
