class Business < ApplicationRecord
    has_many :business_types
    has_many :service_types
#    has_many :contacts, :dependent => :destroy
end
