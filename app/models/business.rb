class Business < ApplicationRecord
  belongs_to :business_type, optional: true
  has_and_belongs_to_many :business_subtypes
  has_and_belongs_to_many :service_types
  has_and_belongs_to_many :zones
  has_many :contacts, :dependent => :destroy
  has_many :awards, :dependent => :destroy
  belongs_to :owner, class_name: :User, foreign_key: :owner_id, optional: true

  has_attached_file :logo, 
    styles: { 
        :large => ["520x180>",:jpg],
        :medium => ["260x90>",:jpg],
        :thumb => ["130x45>",:jpg]
    },
    :convert_options => {
        :thumb => "-quality 75 -strip" },
    :url => "/uploads/db_images/:id/:style_:basename.:extension",  
    :path => ":rails_root/public/uploads/db_images/:id/:style_:basename.:extension",
    :default_url => '/images/no-image.jpg'

  validates_attachment_content_type :logo, :content_type => ["image/jpg", "image/jpeg", "image/png"]

end
