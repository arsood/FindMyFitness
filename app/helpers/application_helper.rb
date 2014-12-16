module ApplicationHelper

	def get_profile_pic_thumb(user_id)
		return User.find(user_id).avatar.url(:thumb)
	end

	def generate_random_md5
		return Digest::MD5.hexdigest(Time.now.to_s)
	end

end
