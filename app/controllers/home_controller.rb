class HomeController < ApplicationController

	def index
		location = request.location

		if location.data["city"] != ""
			@my_location = location.data["city"] + ", " + location.data["region_code"]
		else
			@my_location = "somewhere"
		end

		@events = Event.where("event_date > ?", Time.now).limit(6)

		render "index", layout: "home"
	end

end
