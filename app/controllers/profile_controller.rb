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
		elsif params[:cat] && params[:cat] == "review"
			@my_photos = ReviewPhoto.where(contributor_id: session[:user_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)
			@photo_col = "review_photo"
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

	def profile
		@user = User.find(params[:id])

		@edit_button = false

		render "profile", layout: "inner-info"
	end

	def notifications
		@user = User.find(session[:user_id])

		@notifications = Notification.where(owner_user_id: session[:user_id]).order(created_at: :desc)

		@edit_button = true

		render "profile-notifications", layout: "inner-info"
	end

	def edit
		@user = User.find(session[:user_id])

		@sidebar_header_text = "Edit Your Profile"

		render "profile-edit", layout: "standard-20"
	end

	def update
		user = User.find(session[:user_id])

		user.update_attributes(user_params)

		flash[:success] = "Profile edited successfully!"
		redirect_to "/profile/edit"
	end

	def saves
		@user = User.find(session[:user_id])

		@saves = BusinessSave.where(user_id: session[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		render "profile-saves", layout: "inner-info"
	end

	def upload
		user = User.find(session[:user_id])

		if user.update_attributes(avatar: params[:file])
			render :json => { result: "ok", photo: user.avatar.url(:thumb) }
		else
			render :json => { result: "error", error: "Could not change avatar photo." }
		end
	end

	def get_user_events
		@saved_events = EventSave.where(user_id: session[:user_id]).paginate(:page => params[:page], :per_page => 10)

		@user = User.find(session[:user_id])

		render "profile-events", layout: "inner-info"
	end

	def get_public_user_events
		@saved_events = EventSave.where(user_id: params[:id]).paginate(:page => params[:page], :per_page => 10)

		@user = User.find(params[:id])

		render "profile-events-public", layout: "inner-info"
	end

	def reviews
		@reviews = Review.where(user_id: session[:user_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)

		@user = User.find(session[:user_id])

		render "profile-reviews", layout: "inner-info"
	end

	def public_reviews
		@reviews = Review.where(user_id: params[:id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)

		@user = User.find(params[:id])

		render "profile-reviews-public", layout: "inner-info"
	end

private

	def user_params
		params.require(:user).permit(:password, :first_name, :last_name, :email_address, :city, :state, :avatar, :about_me)
	end
end
