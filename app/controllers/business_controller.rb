class BusinessController < ApplicationController
	def signup
		render "business-signup"
	end

	def signup_process
		#Create a new business with some strong parameters

		newBus = Business.create(bus_params)
		redirect_to "/"
	end

	def business_show
		@business_info = Business.find(params[:id])
		render "business-show"
	end

	private

	def bus_params
		params.require(:business).permit(:name, :business_type, :address, :city, :state, :zipcode, :phone, :website, :monday_start, :monday_end, :tuesday_start, :tuesday_end, :wednesday_start, :wednesday_end, :thursday_start, :thursday_end, :friday_start, :friday_end, :saturday_start, :saturday_end, :sunday_start, :sunday_end, :description)
	end
end
