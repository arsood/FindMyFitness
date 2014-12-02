module BusinessHelper

	def bus_avg_rating(id)
		@average_reviews = Review.where(bus_id: id).average(:star_rating).try(:round)
	end

end
