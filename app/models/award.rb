class Award < ApplicationRecord
  belongs_to :business, optional: true
end
