module BlogHelper

	def get_comment_count(blogId)
		return BlogComment.where(blog_id: blogId).count(:blog_id)
	end

	def get_follow_text(user)
		follower = BlogFollower.where(owner_id: user.id, follower_id: session[:user_id]).exists?

		if follower
			return "Unfollow " + user.first_name
		else
			return "Follow " + user.first_name
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
			return "/assets/temp/slide1.jpg"
		end
	end

end
