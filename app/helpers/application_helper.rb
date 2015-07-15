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
		return Review.where(business_id: id).average(:star_rating).try(:round)
	end

	#Get thumbnail for a business
	def get_bus_thumb(bus_hash, type)
		photo = BusinessPhoto.where(business_hash: bus_hash).order(created_at: :desc)

		if photo.first
			return photo.first.business_photo.url(:medium)
		else
			if type == :link
				return "/assets/image-placeholder.jpg"
			else
				return "image-placeholder.jpg"
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
				return "/assets/image-placeholder.jpg"
			else
				return "image-placeholder.jpg"
			end
		end
	end

	#Get thumbnail for a blog post
	def get_post_thumb(post_hash, type)
		photo = BlogPhoto.where(post_id: post_hash).order(created_at: :desc)

		if photo.first
			return photo.first.post_photo.url(:medium)
		else
			if type == :link
				return "/assets/image-placeholder.jpg"
			else
				return "image-placeholder.jpg"
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

	###Notifications###

	def get_notification_text(type)
		if type == "blog_comment"
			return "has commented on your post,"
		elsif type == "new_follower"
			return "has started following you."
		elsif type == "new_review"
			return "has left you a review."
		elsif type == "post_like"
			return "has liked your post,"
		elsif type == "old_blog_comment"
			return "has commented on the post,"
		end
	end

	def get_notification_title(type, item_id)
		if type == "blog_comment" || type == "old_blog_comment"
			blog_post = Blog.find(item_id)
			return blog_post.post_title
		elsif type == "new_follower"
			return "View all of your followers"
		elsif type == "new_review"
			return "View your business page"
		elsif type == "post_like"
			blog_post = Blog.find(item_id)
			return blog_post.post_title	
		end
	end

	def get_notification_link(type, item_id)
		if type == "blog_comment" || type == "old_blog_comment"
			return "/post/" + item_id.to_s
		elsif type == "new_follower"
			return "/followers"
		elsif type == "new_review"
			return "/business/" + item_id.to_s
		elsif type == "post_like"
			return "/post/" + item_id.to_s
		end
	end

	def set_notification_dismissed(not_id)
		Notification.find(not_id).update_attributes(dismissed: true)
	end

	###/Notifications###

end
