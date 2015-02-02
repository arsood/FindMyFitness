module EventHelper

	def get_event_photo(id)
		return EventPhoto.find(id).event_photo.url(:medium)
	end

end
