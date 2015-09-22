class Business < ActiveRecord::Base
	acts_as_mappable

	has_many :business_services, :foreign_key => "business_id"

	def self.ensure_subscriptions
		users = User.where(user_type: "business")

		users.each do |user|
			if !Subscription.check_subscription(user.id, user.user_type)
				business = Business.where(user_id: user.id).first

				business.update_attributes(account_type: "unpaid")
			end
		end
	end
end
