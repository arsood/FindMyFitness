module BlogHelper

	def get_comment_count(blogId)
		return BlogComment.where(blog_id: blogId).count(:blog_id)
	end

	def get_follow_text(user)
		follower = BlogFollower.where(owner_id: user.id, follower_id: session[:user_id]).exists?

		if follower
			if user.user_type == "standard"
				return "Unfollow " + user.first_name
			else
				business = Business.where(user_id: user.id).first
				return "Unfollow " + business.name
			end
		else
			if user.user_type == "standard"
				return "Follow " + user.first_name
			else
				business = Business.where(user_id: user.id).first
				return "Follow " + business.name
			end
		end 
	end

	def get_following_num(user_id)
		return BlogFollower.where(follower_id: user_id).count
	end

	def get_follower_num(user_id)
		return BlogFollower.where(owner_id: user_id).count
	end

	def get_post_photo(post_id)
		photo = BlogPhoto.where(post_id: post_id).try(:first)

		if photo
			return photo.post_photo.url
		else
			return "/assets/image-placeholder.jpg"
		end
	end

	def get_post_tags(id)
		tags = BlogTag.where(blog_id: id)

		tag_array = []

		tags.each do |tag|
			tag_array << tag.blog_tag
		end

		return tag_array.join(",")
	end

	def get_blog_photo(id)
		return BlogPhoto.find(id).post_photo.url(:medium)
	end

	def get_tag_list(id)
		tags = BlogTag.where(blog_id: id)
		tag_list_array = []
		
		tags.each do |tag|
			tag_list_array << tag.blog_tag
		end

		return tag_list_array.join(", ")
	end

	def get_likes(post_id)
		return BlogLike.where(post_id: post_id).count
	end

end
