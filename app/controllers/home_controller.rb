class HomeController < ApplicationController

	def index
		location = request.location

		if location.data && location.data["city"] != ""
			@my_location = location.data["city"] + ", " + location.data["region_code"]
		else
			@my_location = "somewhere"
		end

		if @my_location == "somewhere"
			@events = Event.where("event_date > ?", Time.now).limit(6)
		else
			@events = Event.where("event_date > ?", Time.now).limit(6).within(20, :origin => [location.data["latitude"], location.data["longitude"]])
		end

		render "index", layout: "home"
	end

end
