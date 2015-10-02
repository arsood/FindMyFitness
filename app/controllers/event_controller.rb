class EventController < ApplicationController
	def index
		if params[:category]
			@events = Event.where("event_date > ?", Time.now).where(event_category: params[:category]).paginate(:page => params[:page], :per_page => 10).order(event_date: :asc)

			@category = params[:category]
		else
			@events = Event.where("event_date > ?", Time.now).paginate(:page => params[:page], :per_page => 10).order(event_date: :asc)
		end

		if session[:user_type] == "business"
			render "index", layout: "business-topbar"
		else
			render "index", layout: "standard-20"
		end
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
		if session[:business_id] || session[:user_type] == "superuser"
			#Generate random hash to be associated with images
			@event_id = Digest::MD5.hexdigest(Time.now.to_s)

			render "new", layout: "business-topbar"
		else
			flash[:error] = "You must be logged in to do that."
			redirect_to "/login"
		end
	end

	def new_event_process
		event_geo = Geokit::Geocoders::GoogleGeocoder.geocode(params[:event][:event_location])

		event_parameters = event_params.merge(business_id: session[:business_id], lat: event_geo.lat, lng: event_geo.lng)

		created_event = Event.create_event(event_parameters)

		if session[:user_type] == "business"
			redirect_to "/business-admin/events/" + session[:business_id].to_s
		else
			redirect_to "/events/" + created_event.id
		end
	end

	def update
		event_geo = Geokit::Geocoders::GoogleGeocoder.geocode(params[:event][:event_location])

		event_parameters = event_params.merge(lat: event_geo.lat, lng: event_geo.lng)

		Event.update_event(event_parameters, params[:id])

		if session[:user_type] == "business"
			redirect_to "/business-admin/events/" + session[:business_id].to_s
		else
			redirect_to "/events/" + created_event.id
		end
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

		@event_saved = EventSave.where(user_id: session[:user_id], event_id: params[:id]).exists?

		if session[:user_type] == "business"
			render "show", layout: "business-topbar"
		else
			render "show", layout: "standard-20"
		end
	end

	def edit
		@event = Event.find(params[:id])

		if session[:business_id] && @event.business_id == session[:business_id]
			@photos = EventPhoto.where(event_id: @event.event_id)
			render "edit", layout: "business-topbar"
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

	def save_event
		event_save = EventSave.where(user_id: session[:user_id], event_id: params[:event_id])

		if event_save.first
			event_save.first.destroy

			render :json => { result: "ok", action: "unsave" }
		else
			EventSave.create(user_id: session[:user_id], event_id: params[:event_id])
			render :json => { result: "ok", action: "save" }
		end
	end

private

	def event_params
		params.require(:event).permit(:event_name, :event_description, :event_category, :event_date_month, :event_date_day, :event_date_year, :event_time, :event_location, :event_id)
	end

end
