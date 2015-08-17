class AdminController < ApplicationController
	before_filter :admin_auth

	def index
		render "admin-index", layout: "standard-20"
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

			if blog.destroy && BlogPhoto.where(post_id: blog.post_id).destroy_all && BlogTag.where(blog_id: params[:id]).destroy_all
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting this post." }
			end
		elsif item_type == "business"
			business = Business.find(params[:id])

			if business.destroy && BusinessPhoto.where(business_hash: business.business_hash).destroy_all && Review.where(bus_id: business.id).destroy_all && BusinessOwner.where(business_id: business.id).destroy_all
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting this business." }
			end
		elsif item_type == "review"
			review = Review.find(params[:id])

			if review.destroy
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting this review." }
			end
		end
	end

	def photos
		if params[:type] == "business"
			@photos = BusinessPhoto.where(business_hash: params[:hash]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
		elsif params[:type] == "event"
			@photos = EventPhoto.where(event_id: params[:hash]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
		elsif params[:type] == "blog"
			@photos = BlogPhoto.where(post_id: params[:hash]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
		end

		render "admin-photos"
	end

	def photos_delete
		if params[:image_type] == "business"
			if BusinessPhoto.find(params[:image_id]).destroy
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting the photo." }
			end
		elsif params[:image_type] == "event"
			if EventPhoto.find(params[:image_id]).destroy
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting the photo." }
			end
		elsif params[:image_type] == "blog"
			if BlogPhoto.find(params[:image_id]).destroy
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting the photo." }
			end
		end
	end

	def manage_users
		if params[:email] && params[:email] != ""
			@users = User.where(email_address: params[:email]).paginate(:page => params[:page], :per_page => 50).order(created_at: :desc)
		else
			@users = User.all.paginate(:page => params[:page], :per_page => 50).order(created_at: :desc)
		end
		
		render "admin-add", layout: "standard-20"
	end

	def manage_users_process
		user = User.find(params[:user_id])

		if params[:user_action] == "revoke"
			if Business.where(user_id: params[:user_id]).exists?
				user.update_attributes(user_type: "business")
			else
				user.update_attributes(user_type: "standard")
			end
		else
			user.update_attributes(user_type: "superuser")
		end

		redirect_to "/admin/users/manage"
	end

private

	def admin_auth
		if session[:user_type] != "superuser"
			raise ActionController::RoutingError.new('Not Found')
		end
	end

end
