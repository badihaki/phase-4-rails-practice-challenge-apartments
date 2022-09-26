class Apartment < ApplicationRecord
    # associations
    has_many :leases
    has_many :tenants, through: :leases

    # validations
    validates :number, presence: true
end
