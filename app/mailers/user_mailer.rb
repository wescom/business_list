class UserMailer < ApplicationMailer
  default from: 'sales@bendbulletin.com'

  def send_welcome_email(user)
    @user = user

    subject = "business.bendbulletin.com - Welcome to The Bulletin's business listings"
    mail(to: @user.email, subject: subject)
  end
end
