class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  
  has_many :businesses, foreign_key: :owner_id, dependent: :nullify
         
  ROLES = %i[admin supervisor sales user]

  after_create :send_admin_mail
  def send_admin_mail
    @default_settings_email = DefaultSettingsEmail.find_by(name: 'Welcome')
    UserMailer.send_welcome_email(self,@default_settings_email).deliver_later unless @default_settings_email.nil? 
  end
    
end
