class Event < ActiveRecord::Base

	def self.create_event(params)
		new_event = Event.new
		new_event.event_name = params[:event_name]
		new_event.event_description = params[:event_description]
		new_event.event_category = params[:event_category]
		new_event.event_location = params[:event_location]
		new_event.event_time = params[:event_time]

		date_obj = DateTime.parse(params[:event_date_year] + "-" + params[:event_date_month] + "-" + params[:event_date_day])

		new_event.event_date = date_obj
		new_event.save
	end

end
