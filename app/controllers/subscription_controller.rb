class SubscriptionController < ApplicationController

	def pay
		reset_session

		@client_token = Braintree::ClientToken.generate
		render "pay", layout: "nothing"
	end

	def subscribe
		customer_result = Braintree::Customer.create(
			:first_name => session[:first_name],
			:last_name => session[:last_name],
			:phone => params[:customer_phone],
			:payment_method_nonce => params[:payment_method_nonce]
		)

		if customer_result.success?
			p "Success in creating customer"

			subscription_result = Braintree::Subscription.create(
				:payment_method_token => customer_result.customer.credit_cards[0].token,
				:plan_id => "fmf_business",
				:id => customer_result.customer.id
			)

			if subscription_result.success?
				p "Subscription created"

				new_user = User.create(email_address: params[:new_email], password: params[:new_password], user_type: "business")

				Subscription.where(user_id: new_user.id).destroy_all
				
				Subscription.create(user_id: new_user.id, plan_type: "fmf_business", subscription_status: "active", customer_id: customer_result.customer.id, customer_token: customer_result.customer.credit_cards[0].token, subscription_id: subscription_result.subscription.id)
				
				session[:user_id] = new_user.id
				session[:signing_up] = true

				redirect_to "/business-signup"
			else
				flash[:error] = "There was an error creating the subscription."
				redirect_to "/subscribe"
			end
		else
			flash[:error] = "There was an error with your card. Please try again."
			redirect_to "/subscribe"
		end
	end
	
end
