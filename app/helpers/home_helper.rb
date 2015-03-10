module HomeHelper

	def get_bus_name(business_id)
		return Business.find(business_id).name
	end

end
