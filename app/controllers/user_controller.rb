class UserController < ApplicationController

	def signup_process
		User.create(user_params)
		redirect_to "/"
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :first_name, :last_name, :email_address, :city, :state, :user_type)
	end

end
