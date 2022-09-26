class LeasesController < ApplicationController

    def create
        new_lease = Lease.create!(permitted_params)
        render json: new_lease, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {errors: ["invalid record, cannot add to database"]}, status: :unprocessable_entity
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Lease doesn't exist in the database"}
    end

    private
    def permitted_params
        params.permit(
            :rent,
            :apartment_id,
            :tenant_id
        )
    end
end
