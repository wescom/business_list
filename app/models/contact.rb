class Contact < ApplicationRecord
    belongs_to :business, optional: true
end
