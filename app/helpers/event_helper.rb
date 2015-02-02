module EventHelper

	def get_event_photo(id)
		return EventPhoto.find(id).event_photo.url(:medium)
	end

	def month_options
		[
			["Jan", "January"],
			["Feb", "February"],
			["Mar", "March"],
			["Apr", "April"],
			["May", "May"],
			["Jun", "June"],
			["Jul", "July"],
			["Aug", "August"],
			["Sep", "September"],
			["Oct", "October"],
			["Nov", "November"],
			["Dec", "December"]
		]
	end

	def day_options
		days = []

		for i in 1..31
			days << [i.to_s, i.to_s]
		end

		return days
	end

	def year_options
		years = []

		for i in 2015..2035
			years << [i.to_s, i.to_s]
		end

		return years
	end

end
