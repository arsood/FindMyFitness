class BusinessController < ApplicationController
	def signup
		render "business-signup"
	end

	def signup_process
		newBus = Business.create(bus_params)
		redirect_to "/"
	end

	private

	def bus_params
		params.require(:business).permit(:name, :business_type, :address, :city, :state, :zipcode, :phone, :website, :monday_start, :monday_end, :tuesday_start, :tuesday_end, :wednesday_start, :wednesday_end, :thursday_start, :thursday_end, :friday_start, :friday_end, :saturday_start, :saturday_end, :sunday_start, :sunday_end, :description)
	end
end
