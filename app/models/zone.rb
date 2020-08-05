class Zone < ApplicationRecord
  has_and_belongs_to_many :businesses
  
  validates :name, uniqueness: true
  validates :name, presence: true
end
