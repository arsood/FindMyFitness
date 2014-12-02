class BusinessService < ActiveRecord::Base
	belongs_to :business, :foreign_key => "bus_id"
end
