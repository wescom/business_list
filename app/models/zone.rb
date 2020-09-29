class Zone < ApplicationRecord
  has_and_belongs_to_many :businesses
  has_many :regions, :dependent => :destroy
  
  validates :name, uniqueness: true
  validates :name, presence: true
end
