class UserController < ApplicationController

	def signup_process
		new_user_data = user_params.merge(avatar: params[:avatar])

		new_user = User.create(new_user_data)

		session[:tmp_user_id] = new_user.id

		redirect_to "/"
	end

	def login_process
		user = User.where(username: params[:username]).first

		if user
			if user.authenticate(params[:password])
				session[:user_id] = user.id
				session[:user_type] = user.user_type
				session[:first_name] = user.first_name
				session[:last_name] = user.last_name

				if user.user_type == "business"
					session[:business_id] = Business.where(user_id: user.id).first.id
					redirect_to "/business-admin"
				else
					redirect_to "/profile"
				end
			else
				flash[:error] = "Sorry, that password was incorrect."

				redirect_to "/login"
			end
		else
			flash[:error] = "Sorry, that username was not found."

			redirect_to "/login"
		end
	end

	def logout_process
		reset_session
		redirect_to "/"
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :first_name, :last_name, :email_address, :city, :state, :avatar, :about_me)
	end

end
