class BusinessController < ApplicationController
	def signup
		render "business-signup"
	end

	def signup_process
		#Create a new business with some strong parameters

		newBus = Business.create(bus_params)
		
		service_params.each do |service|
			BusinessService.create("bus_id" => newBus.id ,"bus_service" => service[1])
		end
		
		redirect_to "/"
	end

	def business_show
		@business_info = Business.find(params[:id])
		@services_info = BusinessService.where(bus_id: @business_info.id)

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
