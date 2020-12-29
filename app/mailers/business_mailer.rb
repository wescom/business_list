class BusinessMailer < ApplicationMailer
  default from: 'sales@bendbulletin.com'

  def business_updated(business,default_settings_email)
    puts "Emailing business_updated"
    @business = business
    @default_settings_email = default_settings_email

    unless @business.owner.nil?
      subject = "business.bendbulletin.com - Business listing '" + @business.name + "' updated"
      mail(
        from: 'Bulletin Business Listings <sales@bendbulletin.com>',
        reply_to: 'sales@bendbulletin.com',
        to: @business.owner.email, 
        subject: subject)
    end
  end
end
