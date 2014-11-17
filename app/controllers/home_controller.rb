class HomeController < ApplicationController
	def index
		if session[:user_id]
			@user = User.find(session[:user_id])

			render "index", layout: false
		end
	end
end
