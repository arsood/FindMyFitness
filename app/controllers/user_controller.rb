class UserController < ApplicationController

	def signup_process
		new_user = User.create(user_params)

		if params[:user][:user_type] == "business"
			session[:business_user_id] = new_user.id
			redirect_to "/business-signup"
		else
			redirect_to "/"
		end
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
		reset_session
		redirect_to "/"
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :first_name, :last_name, :email_address, :city, :state, :user_type)
	end

end
