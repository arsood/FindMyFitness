module ProfileHelper

	def get_notification_text(type)
		if type == "blog_comment"
			return "has commented on your post,"
		elsif type == "new_follower"
			return "has started following you."
		end
	end

	def get_notification_title(type, item_id)
		if type == "blog_comment"
			blog_post = Blog.find(item_id)
			return blog_post.post_title
		elsif type == "new_follower"
			return "View all of your followers"
		end
	end

	def get_notification_link(type, item_id)
		if type == "blog_comment"
			return "/post/" + item_id.to_s
		elsif type == "new_follower"
			return "/followers"
		end
	end

	def set_notification_dismissed(not_id)
		Notification.find(not_id).update_attributes(dismissed: true)
	end
	
end
