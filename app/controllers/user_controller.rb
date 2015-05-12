class UserController < ApplicationController

	def signup_process
		new_user_data = user_params.merge(avatar: params[:avatar])

		new_user = User.create(new_user_data)

		if new_user.errors[:name].any?
			flash[:error] = "There was an error with the signup"
		else
			session[:tmp_user_id] = new_user.id

			flash[:success] = "Thanks for signing up! Please log in."
		end

		redirect_to "/login"
	end

	def check_email
		if User.where(email_address: params[:email_address]).exists?
			render :json => { result: "ok", taken: "taken" }
		else
			render :json => { result: "ok", taken: "no" }
		end
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
					business_owned = BusinessOwner.where(user_id: user.id).first
					session[:business_id] = business_owned.business_id
					session[:business_name] = Business.find(business_owned.business_id).name
				end

				if user.user_type == "superuser"
					redirect_to "/admin"
				elsif user.user_type == "standard"
					redirect_to "/profile"
				elsif user.user_type == "business"
					redirect_to "/business-admin/edit/" + business_owned.business_id.to_s
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

	def forgot_password
		render "forgot-password"
	end

	def forgot_password_1
		user = User.where(email_address: params[:email_address]).first

		if user
			token = Digest::MD5.hexdigest(Time.now.to_s)

			user.reset_token = token

			user.save

			UserMailer.forgot_password(token, user).deliver

			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "No user found." }
		end
	end

	def forgot_password_2
		user = User.where(email_address: params[:email_address], reset_token: params[:reset_token]).first

		if user
			render :json => { result: "ok", token: user.reset_token }
		else
			render :json => { result: "error", error: "Invalid token." }
		end
	end

	def forgot_password_3
		user = User.where(email_address: params[:email_address], reset_token: params[:reset_token]).first

		if user
			user.password = params[:new_password]
			user.save

			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "Invalid credentials." }
		end
	end

private

	def user_params
		params.require(:user).permit(:password, :first_name, :last_name, :email_address, :city, :state, :avatar, :about_me)
	end

end
