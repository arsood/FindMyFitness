module AdminHelper

	def get_site_user_num(type)
		if type == :all
			return User.all.count
		elsif type == :business
			return User.where(user_type: "business").count
		end
	end

	def get_bus_page_num
		return Business.all.count
	end

	def get_admin_photo(photo, type)
		if type == "business"
			return photo.business_photo.url(:medium)
		elsif type == "event"
			return photo.event_photo.url(:medium)
		end
	end

end
