ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address        => 'smtp.gmail.com',
	:port           => 587,
	:user_name      => Rails.application.secrets.mailer_user_name,
	:password       => Rails.application.secrets.mailer_password,
	:authentication => :plain
}