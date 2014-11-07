class EventController < ApplicationController

	def index
		@events = Event.all

		render "index"
	end

	def new
		render "new"
	end

	def new_event_process
		Event.create_event(event_params)

		redirect_to "/"
	end

	private

	def event_params
		params.require(:event).permit(:event_name, :event_description, :event_category, :event_date_month, :event_date_day, :event_date_year, :event_time, :event_location)
	end

end
