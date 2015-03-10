class Event < ActiveRecord::Base

	def self.create_event(params)
		new_event = Event.new
		new_event.event_name = params[:event_name]
		new_event.event_description = params[:event_description]
		new_event.event_category = params[:event_category]
		new_event.event_location = params[:event_location]
		new_event.event_time = params[:event_time]
		new_event.business_id = params[:business_id]
		new_event.lat = params[:lat]
		new_event.lng = params[:lng]

		date_obj = DateTime.parse(params[:event_date_year] + "-" + params[:event_date_month] + "-" + params[:event_date_day])

		new_event.event_date = date_obj
		new_event.event_id = params[:event_id]
		new_event.save
	end

	def self.update_event(params, id)
		edit_event = Event.find(id)
		edit_event.event_name = params[:event_name]
		edit_event.event_description = params[:event_description]
		edit_event.event_category = params[:event_category]
		edit_event.event_location = params[:event_location]
		edit_event.event_time = params[:event_time]
		edit_event.lat = params[:lat]
		edit_event.lng = params[:lng]

		date_obj = DateTime.parse(params[:event_date_year] + "-" + params[:event_date_month] + "-" + params[:event_date_day])

		edit_event.event_date = date_obj
		edit_event.event_id = params[:event_id]
		edit_event.save
	end

end
