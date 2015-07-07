class UserMailer < ActionMailer::Base
  default from: "noreply@findmyfitness.com"

  def forgot_password(token, user)
  	@token = token

  	mail(to: user.email_address, subject: "Reset Your Password")
  end
end
