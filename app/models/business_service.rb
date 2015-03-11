class BusinessService < ActiveRecord::Base
	belongs_to :business, :foreign_key => "business_id"
end
