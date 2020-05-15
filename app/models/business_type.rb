class BusinessType < ApplicationRecord
    has_many :businesses
    has_many :business_subtypes, :dependent => :destroy
    
    validates :name, uniqueness: true
end
