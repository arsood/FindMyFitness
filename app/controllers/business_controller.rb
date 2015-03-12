class BusinessController < ApplicationController
	before_filter :check_subscription, only: [:admin_reviews, :admin_analytics, :get_photos, :admin_events, :admin_blogs]

	def signup
		if session[:signing_up]
			render "business-signup", layout: "nothing"
		else
			flash[:error] = "You must be logged in to do that."
			redirect_to "/login"
		end
	end

	def learn_more
		render "business-learn", layout: "simple-topbar"
	end

	def signup_process
		#Geocode a business address before creating it

		business_geo = Geokit::Geocoders::GoogleGeocoder.geocode(params[:business][:address] + ", " + params[:business][:city] + ", " + params[:business][:state] + " " + params[:business][:zipcode])

		#Merge user_id and geocode results into the business params

		business_params = bus_params.merge(lat: business_geo.lat, lng: business_geo.lng, user_id: session[:user_id])

		#Create the new business

		newBus = Business.create(business_params)
		
		#Add services to a business

		if params[:services]
			service_params.each do |service|
				BusinessService.create(business_id: newBus.id , bus_service: service[1])
			end
		end

		#Save user as the owner of this business

		if session[:signing_up]
			business_paid = "paid"
		else
			business_paid = "unpaid"
		end

		BusinessOwner.create(user_id: session[:user_id], business_id: newBus.id, account_type: business_paid)

		if session[:signing_up]
			reset_session

			flash[:success] = "You're all set! Please log in to your admin panel."
			redirect_to "/login"
		else
			redirect_to "/business/" + newBus.id.to_s
		end
	end

	def update
		business = Business.where(id: params[:business_id]).first

		#Geocode a business address before updating it

		business_geo = Geokit::Geocoders::GoogleGeocoder.geocode(params[:business][:address] + ", " + params[:business][:city] + ", " + params[:business][:state] + " " + params[:business][:zipcode])

		#Merge geocode results into the business params

		business_params = bus_params.merge(lat: business_geo.lat, lng: business_geo.lng)

		#Update the business

		business.update(business_params)
		
		#Add services to the business

		BusinessService.where(business_id: business.id).destroy_all

		service_params.each do |service|
			BusinessService.create("business_id" => business.id ,"bus_service" => service[1])
		end
		
		flash[:bus_update_success] = true

		redirect_to "/business-admin/edit/" + business.id.to_s
	end

	def business_show
		#Pull basic business info
		@business_info = Business.find(params[:id])
		
		#Pull all services related to that business
		@services_info = BusinessService.where(business_id: @business_info.id)

		#Pull all related reviews
		@business_reviews = Review.where(business_id: @business_info.id).order(created_at: :desc)

		@business_photos = BusinessPhoto.where(business_hash: @business_info.business_hash)

		BusinessView.create(business_id: params[:id], user_id: session[:user_id])

		@recent_searches = BusinessView.where(user_id: session[:user_id]).select(:business_id).distinct.order(created_at: :desc).limit(5)

		render "business-show"
	end

	def review_image_upload
		if ReviewPhoto.create(review_hash: params[:review_hash], contributor_id: session[:user_id], review_photo: params[:file])
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "There was an error uploading the file." }
		end
	end

	def save_business
		if BusinessSave.where(user_id: session[:user_id], business_id: params[:business_id]).exists?
			if BusinessSave.where(user_id: session[:user_id], business_id: params[:business_id]).first.destroy

				render :json => { result: "destroyed" }
			else
				render :json => { result: "error", error: "Could not remove business from save list." }
			end
		else
			save_business = BusinessSave.create(user_id: session[:user_id], business_id: params[:business_id])

			if save_business
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "Could not save business." }
			end
		end
	end

	def search
		if params[:query] && params[:location]
			search_query = "%" + params[:query].downcase + "%"
			search_location = params[:location]
		end

		#Get location from query or from IP geocode

		if search_location && search_location != ""
			@businesses = Business.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", search_query, search_query).within(20, :origin => search_location).includes(:business_services).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
		else
			@user_loc = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)

			#User category parameter if present

			if params[:category]
				@businesses = Business.where(business_type: params[:category]).within(5, :origin => [@user_loc.lat, @user_loc.lng]).includes(:business_services).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
			else
				@businesses = Business.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", search_query, search_query).within(20, :origin => [@user_loc.lat, @user_loc.lng]).includes(:business_services).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
			end
		end

		render "business-search"
	end

	def new_review
		review = Review.create(user_id: session[:user_id], business_id: params[:business_id], star_rating: params[:review_stars], review_text: params[:review], review_hash: params[:review_hash])

		owner_id = BusinessOwner.where(business_id: params[:business_id]).first.user_id

		Notification.create(notification_type: "new_review", item_id: review.id, guest_user_id: session[:user_id], owner_user_id: owner_id)

		redirect_to :back
	end

	def admin_index
		@businesses_owned = BusinessOwner.where(user_id: session[:user_id])

		render "admin-index"
	end

	def admin_notifications
		@notifications = Notification.where(owner_user_id: session[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		render "admin-notifications", layout: "nothing"
	end

	def admin_edit
		if is_owner(params[:business_id])
			@business = Business.find(params[:business_id])

			services = BusinessService.where(business_id: @business.id)

			@services = []

			services.each do |service|
				@services << service.bus_service
			end

			@header_text = "Welcome Back, " + @business.name + ". What would you like to do today?"

			render "admin-edit-profile", layout: "nothing"
		else
			redirect_to :back
		end
	end

	def image_upload
		if BusinessPhoto.create(business_hash: params[:business_hash], contributor_id: session[:user_id], business_photo: params[:file])
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "Photo upload failed." }
		end
	end

	def admin_reviews
		if is_owner(params[:business_id])
			@header_text = "Your Reviews"

			@business_reviews = Review.where(business_id: params[:business_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
			
			render "admin-reviews", layout: "nothing"
		else
			redirect_to "/"
		end
	end

	def admin_events
		@events = Event.where(business_id: params[:business_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)

		render "admin-events", layout: "nothing"
	end

	def admin_blogs
		@posts = Blog.where(business_id: session[:business_id]).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)

		render "admin-blogs", layout: "nothing"
	end

	def admin_blogs_new
		@post_id = Digest::MD5.hexdigest(Time.now.to_s)
		@posts = Blog.where(business_id: session[:business_id])
		render "admin-post-new", layout: "nothing"
	end

	def admin_blogs_edit
		@post = Blog.find(params[:post_id])

		@photos = BlogPhoto.where(post_id: @post.post_id)

		render "admin-post-edit", layout: "nothing"
	end

	def admin_analytics
		if is_owner(params[:business_id])
			@saves_num = BusinessSave.where(business_id: params[:business_id]).count
			@review_num = Review.where(business_id: params[:business_id]).count

			render "admin-analytics", layout: "nothing"
		else
			redirect_to "/"
		end
	end

	def get_analytics_views
		analytics_type = params[:type]

		if analytics_type == "24hour"
			views = BusinessView.where(business_id: params[:business_id]).where("created_at BETWEEN ? AND ?", (Time.now - 24.hours), Time.now).order(created_at: :asc)

			labels = []

			views.each do |view|
				time_offset = params[:time_offset].to_i
				created_time = view.created_at - (time_offset.minutes)

				labels << created_time.beginning_of_hour.strftime("%-I %p")
			end

			#Give me a count of each item in groups

			counts = Hash.new(0)

			labels.each do |label|
				counts[label] += 1
			end

			#Spit out JSON formatted for use in Chart.js

			render :json => { labels: labels.uniq, datasets: [
				{
					label: "24 Hour View Data",
		            fillColor: "rgba(151,187,205,0.2)",
		            strokeColor: "rgba(151,187,205,1)",
		            pointColor: "rgba(151,187,205,1)",
		            pointStrokeColor: "#fff",
		            pointHighlightFill: "#fff",
		            pointHighlightStroke: "rgba(151,187,205,1)",
		            data: counts.values
				}
			] }
		elsif analytics_type == "month"
			views = BusinessView.where(business_id: params[:business_id]).where("created_at BETWEEN ? AND ?", (Time.now - 1.month), Time.now).order(created_at: :asc)

			labels = []

			views.each do |view|
				time_offset = params[:time_offset].to_i
				created_time = view.created_at - (time_offset.minutes)

				labels << created_time.strftime("%e")
			end

			#Give me a count of each item in groups

			counts = Hash.new(0)

			labels.each do |label|
				counts[label] += 1
			end

			#Spit out JSON formatted for use in Chart.js

			render :json => { labels: labels.uniq, datasets: [
				{
					label: "Past Month View Data",
		            fillColor: "rgba(151,187,205,0.2)",
		            strokeColor: "rgba(151,187,205,1)",
		            pointColor: "rgba(151,187,205,1)",
		            pointStrokeColor: "#fff",
		            pointHighlightFill: "#fff",
		            pointHighlightStroke: "rgba(151,187,205,1)",
		            data: counts.values
				}
			] }
		elsif analytics_type == "year"
			views = BusinessView.where(business_id: params[:business_id]).where("created_at BETWEEN ? AND ?", (Time.now - 1.year), Time.now).order(created_at: :asc)

			labels = []

			views.each do |view|
				time_offset = params[:time_offset].to_i
				created_time = view.created_at - (time_offset.minutes)

				labels << created_time.strftime("%B")
			end

			#Give me a count of each item in groups

			counts = Hash.new(0)

			labels.each do |label|
				counts[label] += 1
			end

			#Spit out JSON formatted for use in Chart.js

			render :json => { labels: labels.uniq, datasets: [
				{
					label: "Past Year View Data",
		            fillColor: "rgba(151,187,205,0.2)",
		            strokeColor: "rgba(151,187,205,1)",
		            pointColor: "rgba(151,187,205,1)",
		            pointStrokeColor: "#fff",
		            pointHighlightFill: "#fff",
		            pointHighlightStroke: "rgba(151,187,205,1)",
		            data: counts.values
				}
			] }
		end
	end

	def get_photos
		@bus_hash = Business.find(params[:business_id]).business_hash

		@bus_photos = BusinessPhoto.where(business_hash: @bus_hash).paginate(:page => params[:page], :per_page => 8).order(created_at: :desc)

		render "admin-photos", layout: "nothing"
	end

	def delete_photo
		if is_owner(params[:business_id])
			if BusinessPhoto.find(params[:image_id]).destroy
				render :json => { result: "ok" }
			else
				render :json => { result: "error", error: "There was a problem deleting that photo." }
			end
		else
			render :json => { result: "error", error: "You do not have permission to delete this photo." }
		end
	end

	def admin_save_reply
		if params[:reply_text] == ""
			redirect_to :back
		else
			if ReviewReply.create(business_id: session[:business_id], review_id: params[:review_id], reply_text: params[:reply_text])
				redirect_to :back
			end
		end
	end

private

	def is_owner(business_id)
		owner = BusinessOwner.where(user_id: session[:user_id], business_id: business_id).exists?

		if owner || session[:user_type] == "superuser"
			return true
		else
			return false
		end
	end

	def bus_params
		params.require(:business).permit(:name, :business_type, :address, :city, :state, :zipcode, :phone, :website, :description, :availability, :business_hash)
	end

	def service_params
		params.require(:services).permit(:weights, :track, :pool, :classes, :instructors, :pilates, :spa, :sauna, :massage, :cycling, :courts, :cardio, :diet, :towels, :steam, :cafe, :child_care, :meditation)
	end
end
