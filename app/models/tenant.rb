class Tenant < ApplicationRecord
    # associations
    has_many :leases
    has_many :apartments, through: :leases

    # validates
    validates :name, presence: true
    validate :check_age

    private

    def check_age
        if(self.age <= 17)
            errors.add(:age, "Tenant too young")
        end
    end
end
