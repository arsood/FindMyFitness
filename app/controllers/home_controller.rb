class HomeController < ApplicationController

	def index
		begin
			location = request.location

			if location.data && location.data["city"] != ""
				@my_location = location.data["city"] + ", " + location.data["region_code"]
			else
				@my_location = "somewhere"
			end
		rescue
			@my_location = "somewhere"
		end

		if @my_location == "somewhere"
			@events = Event.where("event_date > ?", Time.now).limit(6)
		else
			@events = Event.where("event_date > ?", Time.now).limit(6).within(125, :origin => [location.data["latitude"], location.data["longitude"]]).by_distance(:origin => [location.data["latitude"], location.data["longitude"]])
		end

		render "index", layout: "home"
	end

end
