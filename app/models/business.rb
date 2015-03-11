class Business < ActiveRecord::Base
	acts_as_mappable

	has_many :business_services, :foreign_key => "business_id"
end
