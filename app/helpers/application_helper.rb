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
		@average_reviews = Review.where(bus_id: id).average(:star_rating).try(:round)
	end

	#Get thumbnail for a business
	def get_bus_thumb(bus_hash)
		return BusinessPhoto.where(business_hash: bus_hash).order(created_at: :desc).first.business_photo.url(:medium)
	end

	#Get count of notifications for a user
	def get_notification_count(user_id)
		return Notification.where(owner_user_id: user_id, dismissed: false).count
	end

end
