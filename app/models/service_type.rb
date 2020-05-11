class ServiceType < ApplicationRecord
    has_and_belongs_to_many :businesses
end
