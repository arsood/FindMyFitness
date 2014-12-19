module BusinessHelper

	def bus_avg_rating(id)
		@average_reviews = Review.where(bus_id: id).average(:star_rating).try(:round)
	end

	def bus_is_saved?(bus_id)
		return BusinessSave.where(user_id: session[:user_id], business_id: bus_id).exists?
	end

end
