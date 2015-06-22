class MiscController < ApplicationController
	def about
		@header_text = "About Find My Fitness"
		render "about", layout: "inner-basic"
	end

	def contact
		@header_text = "Contact Us"
		render "contact", layout: "inner-basic"
	end

	def careers
		@header_text = "Careers"
		render "careers", layout: "inner-basic"
	end

	def advertise
		@header_text = "Advertise with Us"
		render "advertise", layout: "inner-basic"
	end
end
