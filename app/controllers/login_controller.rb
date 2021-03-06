class LoginController < ApplicationController
	def index
		if session[:user_id]
			if session[:user_type] == "standard"
				redirect_to "/profile"
			elsif session[:user_type] == "business"
				business_id = Business.where(user_id: session[:user_id]).first.id
				redirect_to "/business-admin/edit/" + business_id.to_s
			else
				redirect_to "/profile"
			end
		else
			render "index", layout: "standard-20"
		end
	end

	def fb_auth
		user = User.where(auth_id: auth_hash.uid).first

		if user
			session[:user_id] = user.id
			session[:user_type] = user.user_type
			session[:first_name] = user.first_name
			session[:last_name] = user.last_name
			session[:social_user] = true
				
			redirect_to "/profile"
		else
			fb_user = User.create(first_name: auth_hash.info.first_name, last_name: auth_hash.info.last_name, email_address: auth_hash.info.email, auth_id: auth_hash.uid, password: Time.now, fb_img: auth_hash.info.image)

			session[:user_id] = fb_user.id
			session[:user_type] = fb_user.user_type
			session[:first_name] = fb_user.first_name
			session[:last_name] = fb_user.last_name
			session[:social_user] = true

			flash[:new_user] = true

			redirect_to "/profile"
		end
	end

protected

	def auth_hash
		request.env['omniauth.auth']
	end

end
