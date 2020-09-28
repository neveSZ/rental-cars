module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

      private

      def render_not_found(_exception)
        render status: :not_found,
               json: "#{controller_name
                          .classify
                          .constantize
                          .model_name
                          .human} não encontrado"
      end

      def render_record_invalid(exception)
        render status: :unprocessable_entity, json: exception.message
      end
    end
  end
end
