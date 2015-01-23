module ProfileHelper

	def us_states
		[
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
