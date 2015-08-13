ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	address: 'smtp.mandrillapp.com',
	port: 587,
	domain: 'findmyfitness.com',
	user_name: Rails.application.secrets.mandrill_username,
	password: Rails.application.secrets.mandrill_api_key,
	authentication: 'plain'
}