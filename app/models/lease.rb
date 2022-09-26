class Lease < ApplicationRecord
    # associations
    belongs_to :tenant
    belongs_to :apartment

    # validations
    validates :rent, presence: true, numericality: {only_integer: true}
    validates :tenant_id, presence: true
    validates :apartment_id, presence: true
    validate :check_tenant
    validate :check_apartment

    private

    def check_tenant
        tenant = Tenant.find_by(id: self.tenant_id)
        if(tenant === nil)
            errors.add(:tenant_id, "tenant doesn't exist")
        end
    end

    def check_apartment
        apartment = Apartment.find_by(id: self.apartment_id)
        if(apartment === nil)
            errors.add(:apartment_id, "No apartment with that ID exists")
        end
    end

    def check_apartment
    end
end
