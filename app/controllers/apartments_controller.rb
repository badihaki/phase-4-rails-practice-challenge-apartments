class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    
    def index
        render json: Apartment.all, status: :ok
    end

    def show
        render json: find_apartment(), status: :found
    end

    def create
        new_apartment = Apartment.create!(permitted_params)
        render json: new_apartment, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: {errors: ["invalid record, cannot add to database"]}, status: :unprocessable_entity
    end

    def update
        apartment = find_apartment()
        apartment.update(permitted_params)
        render json: apartment, status: :accepted
    end

    def destroy
        apartment = find_apartment()
        apartment.destroy
        head :no_content
    end

    private

    def find_apartment
        Apartment.find(params[:id])
    end

    def permitted_params
        params.permit(:number)
    end

    def not_found_response
        render json: {error: "Apartment not found"}, status: :not_found
    end
end
