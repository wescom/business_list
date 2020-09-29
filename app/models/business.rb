class Business < ApplicationRecord
  belongs_to :business_type, optional: true
  belongs_to :region, optional: true
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

  validates :name, presence: true, if: :active_or_info?
  validates :address1, :city, :state, :zipcode, :phonenum, :email, presence: true, if: :active_or_location?
  validates :business_type_id, presence: { message: "must select at least one" }, if: :active_or_services?
  validates :service_types, presence: { message: "must select at least one" }, if: :active_or_services?
  validates :zones, presence: { message: "must select at least one" }, if: :active_or_services?
  #validates :business_type_id, presence: true, if: :active_or_extras?
  #validates :business_type_id, presence: true, if: :active_or_contacts?

  def active?
    status == 'active'
  end

  def active_or_info?
    status.include?('business_info') || active?
  end

  def active_or_location?
    status.include?('business_location') || active?
  end

  def active_or_services?
    status.include?('business_services') || active?
  end

  def active_or_extras?
    status.include?('business_extras') || active?
  end

  def active_or_contacts?
    status.include?('business_contacts') || active?
  end
end
