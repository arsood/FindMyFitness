class Subscription < ActiveRecord::Base

	def self.check_subscription(user_id)
		subscription = Subscription.where(user_id: user_id).first

		bt_subscription = Braintree::Subscription.find(subscription.subscription_id)

		if bt_subscription.status == "Active"
			return true
		else
			subscription.update_attributes(subscription_status: bt_subscription.status)
			return false
		end
	end

end
