class Region < ApplicationRecord
  belongs_to :zone, optional: true
  has_many :businesses

  validates :name, uniqueness: { scope: :zone_id }
  validates :name, presence: true

  def zone_name_region_name
    "#{zone.name} - #{name}"
  end
end
