class SubscriptionController < ApplicationController

	def pay
		@client_token = Braintree::ClientToken.generate
		render "pay", layout: "home"
	end

	def subscribe
		customer_result = Braintree::Customer.create(
			:first_name => session[:first_name],
			:last_name => session[:last_name],
			:phone => params[:customer_phone],
			:payment_method_nonce => params[:payment_method_nonce]
		)

		if customer_result.success?
			subscription_result = Braintree::Subscription.create(
				:payment_method_token => customer_result.customer.credit_cards[0].token,
				:plan_id => "fmf_business",
				:id => customer_result.customer.id
			)

			if subscription_result.success?
				Subscription.create(user_id: session[:user_id], plan_type: "fmf_business", subscription_status: "active", customer_id: customer_result.customer.id, customer_token: customer_result.customer.credit_cards[0].token, subscription_id: subscription_result.subscription.id)
			else
				p subscription_result.errors
				flash[:error] = subscription_result.errors
				redirect_to "/subscribe"
			end
		else
			flash[:error] = customer_result.errors
			redirect_to "/subscribe"
		end
	end

end
