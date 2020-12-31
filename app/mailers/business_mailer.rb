class BusinessMailer < ApplicationMailer
  default from: 'sales@bendbulletin.com'

  def business_updated(business,default_settings_email)
    puts "Emailing business_updated"
    @business = business
    @default_settings_email = default_settings_email

    unless @business.owner.nil?
      subject = @default_settings_email.email_subject
      mail(
        from: 'Bulletin Business Listings <sales@bendbulletin.com>',
        reply_to: @default_settings_email.email_from_address,
        to: @business.owner.email, 
        subject: subject
        )
    end
  end

  def business_waiting_for_approval(business,default_settings_email)
    puts "Emailing business_waiting_for_approval"
    @business = business
    @default_settings_email = default_settings_email

    unless @business.owner.nil?
      subject = @default_settings_email.email_subject
      mail(
        from: 'Bulletin Business Listings <'+@default_settings_email.email_from_address+'>',
        reply_to: @default_settings_email.email_from_address,
        to: @default_settings_email.email_from_address, 
        subject: subject
        )
    end
  end
end
