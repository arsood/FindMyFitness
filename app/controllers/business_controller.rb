class BusinessController < ApplicationController
	def signup
		if session[:business_user_id]
			@header_text = "Create Your Business Profile"
			render "business-signup", layout: "inner-basic"
		else
			redirect_to "/"
		end
	end

	def signup_process
		#Geocode a business address before creating it

		business_geo = Geokit::Geocoders::GoogleGeocoder.geocode(params[:business][:address] + ", " + params[:business][:city] + ", " + params[:business][:state] + " " + params[:business][:zipcode])

		#Merge user_id and geocode results into the business params

		business_params = bus_params.merge(user_id: session[:business_user_id], lat: business_geo.lat, lng: business_geo.lng)

		#Create the new business

		newBus = Business.create(business_params)
		
		#Add services to a business

		service_params.each do |service|
			BusinessService.create("bus_id" => newBus.id ,"bus_service" => service[1])
		end

		reset_session
		
		redirect_to "/"
	end

	def update
		business = Business.where(user_id: session[:user_id]).first

		#Geocode a business address before updating it

		business_geo = Geokit::Geocoders::GoogleGeocoder.geocode(params[:business][:address] + ", " + params[:business][:city] + ", " + params[:business][:state] + " " + params[:business][:zipcode])

		#Merge geocode results into the business params

		business_params = bus_params.merge(lat: business_geo.lat, lng: business_geo.lng)

		#Update the business

		business.update(business_params)
		
		#Add services to the business

		BusinessService.where(bus_id: business.id).destroy_all

		service_params.each do |service|
			BusinessService.create("bus_id" => business.id ,"bus_service" => service[1])
		end
		
		flash[:bus_update_success] = true

		redirect_to "/business-admin"
	end

	def business_show
		#Pull basic business info
		@business_info = Business.find(params[:id])
		
		#Pull all services related to that business
		@services_info = BusinessService.where(bus_id: @business_info.id)

		#Pull all related reviews
		@business_reviews = Review.where(bus_id: @business_info.id).order(created_at: :desc)

		@business_photos = BusinessPhoto.where(business_hash: @business_info.business_hash)

		render "business-show"
	end

	def save_business
		save_business = BusinessSave.create(user_id: session[:user_id], business_id: params[:business_id])

		if save_business
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "Could not save business." }
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
		Review.create(user_id: session[:user_id], bus_id: params[:business_id], star_rating: params[:review_stars], review_text: params[:review])

		redirect_to :back
	end

	def admin_index
		if session[:user_type] == "business" && session[:business_id]
			@business = Business.where(user_id: session[:user_id]).first

			services = BusinessService.where(bus_id: @business.id)

			@services = []

			services.each do |service|
				@services << service.bus_service
			end

			@header_text = "Welcome Back, " + @business.name + ". What would you like to do today?"

			render "admin-edit-profile", layout: "inner-basic"
		else
			flash[:error] = "You are not logged in as a business user."
			redirect_to "/login"
		end
	end

	def image_upload
		if BusinessPhoto.create(business_hash: params[:business_hash], contributor_id: session[:tmp_user_id], business_photo: params[:file])
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "Photo upload failed." }
		end
	end

	def admin_reviews
		@header_text = "Your Reviews"

		@business_reviews = Review.where(bus_id: session[:business_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
		
		render "admin-reviews", layout: "inner-basic"
	end

	private

	def bus_params
		params.require(:business).permit(:name, :business_type, :address, :city, :state, :zipcode, :phone, :website, :description, :availability, :business_hash)
	end

	def service_params
		params.require(:services).permit(:weights, :track, :pool, :classes, :instructors, :pilates, :spa, :sauna, :massage, :cycling, :courts, :cardio, :diet, :towels, :steam, :cafe, :child_care, :meditation)
	end
end
