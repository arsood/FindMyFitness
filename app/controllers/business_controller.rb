class BusinessController < ApplicationController
	def signup
		if session[:business_user_id]
			render "business-signup"
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

	def business_show
		#Pull basic business info
		@business_info = Business.find(params[:id])
		
		#Pull all services related to that business
		@services_info = BusinessService.where(bus_id: @business_info.id)

		#Pull all related reviews
		@business_reviews = Review.where(bus_id: @business_info.id).order(created_at: :desc)

		render "business-show"
	end

	def save_business
		render :text => "Worked"
	end

	private

	def bus_params
		params.require(:business).permit(:name, :business_type, :address, :city, :state, :zipcode, :phone, :website, :description, :availability)
	end

	def service_params
		params.require(:services).permit(:weights, :track, :pool, :classes, :instructors, :pilates, :spa, :sauna, :massage, :cycling, :courts, :cardio)
	end
end
