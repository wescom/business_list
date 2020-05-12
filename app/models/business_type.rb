class BusinessType < ApplicationRecord
    has_many :businesses
    
    validates :name, uniqueness: true
end
