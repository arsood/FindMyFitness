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
		if session[:user_id]
			#Generate random hash to be associated with images
			@event_id = Digest::MD5.hexdigest(Time.now.to_s)

			render "new"
		else
			flash[:error] = "You must be logged in to do that."
			redirect_to "/login"
		end
	end

	def new_event_process
		event_parameters = event_params.merge(user_id: session[:user_id])

		Event.create_event(event_parameters)

		redirect_to "/events"
	end

	def update
		Event.update_event(event_params, params[:id])

		redirect_to "/profile/events"
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

	def edit
		@event = Event.find(params[:id])

		if @event.user_id == session[:user_id]
			@photos = EventPhoto.where(event_id: @event.event_id)
			render "edit"
		else
			flash[:error] = "You must be logged in to do that."
			redirect_to "/login"
		end
	end

	def image_delete
		if EventPhoto.find(params[:image_id]).destroy
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "There was a problem deleting this photo." }
		end
	end

private

	def event_params
		params.require(:event).permit(:event_name, :event_description, :event_category, :event_date_month, :event_date_day, :event_date_year, :event_time, :event_location, :event_id)
	end

end
