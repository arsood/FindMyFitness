class HomeController < ApplicationController

	def index
		location = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
		
		if location.success
			@my_location = location.city + ", " + location.state_code
		else
			@my_location = "somewhere"
		end

		render "index", layout: "home"
	end
	
end
