class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response


    def index
        render json: Tenant.all, status: :ok
    end

    def show
        render json: find_tenant(), status: :found
    end

    def create
        new_tenant = Tenant.create!(permitted_params)
        render json: new_tenant, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {errors: ["invalid record, cannot add to database"]}, status: :unprocessable_entity
    end

    def update
        tenant = find_tenant()
        tenant.update(permitted_params)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = find_tenant()
        tenant.destroy
        head :no_content
    end

    private

    def find_tenant
        Tenant.find(params[:id])
    end

    def permitted_params
        params.permit(:name, :age)
    end

    def not_found_response
        render json: {error: "tenant not found"}, status: :not_found
    end
end
