module ApplicationHelper

	def get_profile_pic_thumb(user_id)
		return User.find(user_id).avatar.url(:thumb)
	end

end
