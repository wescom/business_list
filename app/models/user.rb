class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  
  has_many :businesses, :foreign_key => "owner_id"
         
  ROLES = %i[admin supervisor sales user]

  after_create :send_admin_mail
  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
  end
    
end
