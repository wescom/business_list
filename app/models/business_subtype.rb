class BusinessSubtype < ApplicationRecord
  belongs_to :business_type, optional: true
  has_and_belongs_to_many :businesses

  validates :name, uniqueness: { scope: :business_type_id }
end
