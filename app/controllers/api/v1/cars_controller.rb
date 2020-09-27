module Api
  module V1
    class CarsController < ApiController
      def index
        render json: Car.available
      end
    end
  end
end
