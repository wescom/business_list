class BusinessType < ApplicationRecord
    has_many :businesses
    has_many :business_subtypes, :dependent => :destroy
    
    validates :name, uniqueness: true
    validates :name, presence: true
    validates :title_for_subtypes, presence: true
end
