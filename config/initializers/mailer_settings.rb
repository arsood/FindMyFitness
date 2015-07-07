ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      Rails.application.secrets.mandrill_username,
    :password =>       Rails.application.secrets.mandrill_api_key,
    :domain =>         'findmyfitness.com',
    :authentication => :plain
}