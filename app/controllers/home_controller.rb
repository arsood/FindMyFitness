class HomeController < ApplicationController

	def index
		location = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip)
		
		if location.success
			@my_location = location.city + ", " + location.state_code
		else
			@my_location = "somewhere"
		end

		@events = Event.where("event_date > ?", Time.now).limit(6)

		render "index", layout: "home"
	end

end
