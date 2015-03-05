class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def check_subscription
		if !Subscription.check_subscription(session[:user_id])
			redirect_to "/business/learn-more"
		end
	end
end
