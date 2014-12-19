module BusinessHelper

	def bus_is_saved?(bus_id)
		return BusinessSave.where(user_id: session[:user_id], business_id: bus_id).exists?
	end

end
