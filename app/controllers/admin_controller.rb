class AdminController < ApplicationController

	def index
		render "admin-index"
	end

	def delete
		item_type = params[:type]

		if item_type == "event"
			event = Event.find(params[:id])

			if event.destroy && EventPhoto.where(event_id: event.event_id).destroy_all
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting this event." }
			end
		elsif item_type == "post"
			blog = Blog.find(params[:id])

			if blog.destroy && BlogPhoto.where(post_id: blog.post_id).destroy_all
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting this event." }
			end
		elsif item_type == "business"
			business = Business.find(params[:id])

			if business.destroy && BusinessPhoto.where(business_hash: business.business_hash).destroy_all && Review.where(bus_id: business.id).destroy_all
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting this event." }
			end
		end
	end

end
