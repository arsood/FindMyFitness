module ApplicationHelper
	#Get avatar in any size!
	def get_user_avatar(user_id, size)
		user = User.find(user_id)

		if user.auth_id && !user.avatar.exists?
			return user.fb_img
		else
			if size == :small
				return user.avatar.url(:thumb)
			elsif size == :medium
				return user.avatar.url(:medium)
			elsif size == :original
				return user.avatar.url
			end
		end
	end

	#Generate a random MD5 hash for use in unique id's
	def generate_random_md5
		return Digest::MD5.hexdigest(Time.now.to_s)
	end

	#Returns full user object for a user
	def get_user_info(user_id)
		return User.find(user_id)
	end

	#Returns full business object for business
	def get_bus_info(bus_id)
		return Business.find(bus_id)
	end

	#Gets member since 12/12/12
	def get_member_since(user_id)
		return User.find(user_id).created_at.strftime("%m/%-d/%Y")
	end

	#Get average business rating
	def bus_avg_rating(id)
		return Review.where(bus_id: id).average(:star_rating).try(:round)
	end

	#Get thumbnail for a business
	def get_bus_thumb(bus_hash, type)
		photo = BusinessPhoto.where(business_hash: bus_hash).order(created_at: :desc)

		if photo.first
			return photo.first.business_photo.url(:medium)
		else
			if type == :link
				return "/assets/temp/slide1.jpg"
			else
				return "temp/slide1.jpg"
			end
		end
	end

	#Get thumbnail for an event
	def get_event_thumb(event_hash, type)
		photo = EventPhoto.where(event_id: event_hash).order(created_at: :desc)

		if photo.first
			return photo.first.event_photo.url(:medium)
		else
			if type == :link
				return "/assets/temp/slide1.jpg"
			else
				return "temp/slide1.jpg"
			end
		end
	end

	#Get count of notifications for a user
	def get_notification_count(user_id)
		return Notification.where(owner_user_id: user_id, dismissed: false).count
	end

	#Return a list of all US states
	def us_states
		[
			['Choose State', ''],
			['Alabama', 'AL'],
			['Alaska', 'AK'],
			['Arizona', 'AZ'],
			['Arkansas', 'AR'],
			['California', 'CA'],
			['Colorado', 'CO'],
			['Connecticut', 'CT'],
			['Delaware', 'DE'],
			['District of Columbia', 'DC'],
			['Florida', 'FL'],
			['Georgia', 'GA'],
			['Hawaii', 'HI'],
			['Idaho', 'ID'],
			['Illinois', 'IL'],
			['Indiana', 'IN'],
			['Iowa', 'IA'],
			['Kansas', 'KS'],
			['Kentucky', 'KY'],
			['Louisiana', 'LA'],
			['Maine', 'ME'],
			['Maryland', 'MD'],
			['Massachusetts', 'MA'],
			['Michigan', 'MI'],
			['Minnesota', 'MN'],
			['Mississippi', 'MS'],
			['Missouri', 'MO'],
			['Montana', 'MT'],
			['Nebraska', 'NE'],
			['Nevada', 'NV'],
			['New Hampshire', 'NH'],
			['New Jersey', 'NJ'],
			['New Mexico', 'NM'],
			['New York', 'NY'],
			['North Carolina', 'NC'],
			['North Dakota', 'ND'],
			['Ohio', 'OH'],
			['Oklahoma', 'OK'],
			['Oregon', 'OR'],
			['Pennsylvania', 'PA'],
			['Puerto Rico', 'PR'],
			['Rhode Island', 'RI'],
			['South Carolina', 'SC'],
			['South Dakota', 'SD'],
			['Tennessee', 'TN'],
			['Texas', 'TX'],
			['Utah', 'UT'],
			['Vermont', 'VT'],
			['Virginia', 'VA'],
			['Washington', 'WA'],
			['West Virginia', 'WV'],
			['Wisconsin', 'WI'],
			['Wyoming', 'WY']
		]
	end

end
