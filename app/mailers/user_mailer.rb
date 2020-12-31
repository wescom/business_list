class UserMailer < ApplicationMailer
  default from: 'sales@bendbulletin.com'

  def send_welcome_email(user,default_settings_email)
    puts "Emailing welcome"
    @user = user
    @default_settings_email = default_settings_email

    subject = @default_settings_email.email_subject
    mail(
      from: 'Bulletin Business Listings <'+@default_settings_email.email_from_address+'>',
      reply_to: @default_settings_email.email_from_address,
      to: @user.email, 
      subject: subject
      )
  end
end
