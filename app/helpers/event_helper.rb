module EventHelper

	def get_event_photo(id)
		return EventPhoto.find(id).event_photo.url(:medium)
	end

	def get_first_event_photo(event_hash, photo_type)
		event_photo = EventPhoto.where(event_id: event_hash).try(:first)
		
		if event_photo
			return event_photo.event_photo.url(:medium)
		else
			if photo_type == :link
				return "image-placeholder.jpg"
			else
				return "/assets/image-placeholder.jpg"
			end
		end
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
