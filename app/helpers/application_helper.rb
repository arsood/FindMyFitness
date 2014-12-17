module ApplicationHelper

	#Grab a user's profile pic thumb
	def get_profile_pic_thumb(user_id)
		return User.find(user_id).avatar.url(:thumb)
	end

	#Generate a random MD5 hash for use in unique id's
	def generate_random_md5
		return Digest::MD5.hexdigest(Time.now.to_s)
	end

	#Returns full user object for a user
	def get_user_info(user_id)
		return User.find(user_id)
	end

	#Gets member since 12/12/12
	def get_member_since(user_id)
		return User.find(user_id).created_at.strftime("%m/%-d/%Y")
	end

end
