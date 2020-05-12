class Business < ApplicationRecord
    belongs_to :business_type, optional: true
    belongs_to :service_type, optional: true
#    has_many :contacts, :dependent => :destroy
end
