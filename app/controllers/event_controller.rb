class EventController < ApplicationController
	def index
		if params[:category]
			@events = Event.where("event_date > ?", Time.now).where(event_category: params[:category]).paginate(:page => params[:page], :per_page => 10).order(event_date: :asc)

			@category = params[:category]
		else
			@events = Event.where("event_date > ?", Time.now).paginate(:page => params[:page], :per_page => 10).order(event_date: :asc)
		end

		render "index"
	end

	def get_all_events
		events = Event.where("event_date > ?", Time.now)

		events_array = []

		events.each do |event|
			events_array << {
				id: event.id,
				title: event.event_name,
				start: event.event_date.strftime("%Y-%m-%d"),
				allDay: true
			}
		end

		render :json => events_array
	end

	def new
		#Generate random hash to be associated with images
		@event_id = Digest::MD5.hexdigest(Time.now.to_s)

		render "new"
	end

	def new_event_process
		Event.create_event(event_params)

		redirect_to "/"
	end

	def image_upload
		if EventPhoto.create(event_photo: params[:file], event_id: params[:event_id], contributor_id: session[:user_id])
			render :text => "ok"
		else
			render :text => "not ok"
		end
	end

	def show
		@event = Event.find(params[:id])
		@event_photos = EventPhoto.where(event_id: @event.event_id)
	end

	private

	def event_params
		params.require(:event).permit(:event_name, :event_description, :event_category, :event_date_month, :event_date_day, :event_date_year, :event_time, :event_location, :event_id)
	end

end
