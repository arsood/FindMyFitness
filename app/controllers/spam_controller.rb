class SpamController < ApplicationController

	def report_review
		if SpamMailer.review_spam(params[:review_id]).deliver
			render :json => { result: "ok" }
		end
	end

	def report_photos
		if SpamMailer.photos_spam(params[:photo_hash], params[:photo_type]).deliver
			render :json => { result: "ok" }
		end
	end

end
