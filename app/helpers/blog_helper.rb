module BlogHelper

	def get_comment_count(blogId)
		return BlogComment.where(blog_id: blogId).count(:blog_id)
	end

end
