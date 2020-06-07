class UserMailer < ApplicationMailer
  default from: 'business@utility.wescompapers.com'

  def send_welcome_email(user)
    @user = user

    subject = "business.bendbulletin.com - Welcome to our listings"
    mail(to: @user.email, subject: subject)
  end
end
