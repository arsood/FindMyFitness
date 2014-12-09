class ProfileController < ApplicationController
	def my_photos
		@user = User.find(session[:user_id])
		
		if !params[:cat] || params[:cat] == "business"
			@my_photos = BusinessPhoto.where(contributor_id: session[:user_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)
			@photo_col = "business_photo"
		elsif params[:cat] && params[:cat] == "event"
			@my_photos = EventPhoto.where(contributor_id: session[:user_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)
			@photo_col = "event_photo"
		elsif params[:cat] && params[:cat] == "blog"
			@my_photos = BlogPhoto.where(contributor_id: session[:user_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)
			@photo_col = "post_photo"
		end

		render "profile-photos", layout: "inner-info"
	end

	def delete_photo
		if params[:image_type] == "business_photo"
			photo = BusinessPhoto.find(params[:image_id])
		elsif params[:image_type] == "event_photo"
			photo = EventPhoto.find(params[:image_id])
		elsif params[:image_type] == "post_photo"
			photo = BlogPhoto.find(params[:image_id])
		end

		if photo.destroy
			render :json => { result: "ok" }
		else
			render :json => { error: "Could not delete photo." }
		end
	end
end
