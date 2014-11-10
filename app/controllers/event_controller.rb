class EventController < ApplicationController

	def index
		#Paginate the events!!!

		@events = Event.paginate(:page => params[:page]).order(created_at: :desc)

		render "index"
	end

	def new
		render "new"
	end

	def new_event_process
		Event.create_event(event_params)

		redirect_to "/"
	end

	def image_upload
		render :text => "ok"
	end

	private

	def event_params
		params.require(:event).permit(:event_name, :event_description, :event_category, :event_date_month, :event_date_day, :event_date_year, :event_time, :event_location)
	end

end
