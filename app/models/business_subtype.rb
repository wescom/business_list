class BusinessSubtype < ApplicationRecord
  belongs_to :business_type, optional: true
end
