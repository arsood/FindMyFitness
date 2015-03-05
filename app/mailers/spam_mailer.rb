class SpamMailer < ActionMailer::Base
	default from: "arun.emboldenmedia@gmail.com"

	def review_spam(review_id)
		review = Review.find(review_id)
		@business_link = "http://findmyfitness.com/business/" + review.bus_id.to_s

		mail(to: "arun.emboldenmedia@gmail.com", subject: "Spam Report - Review")
	end

	def photos_spam(photo_hash, photo_type)
		@photos_link = "http://findmyfitness.com/admin/photos/" + photo_type + "?hash=" + photo_hash

		mail(to: "arun.emboldenmedia@gmail.com", subject: "Spam Report - Photos")
	end
end
