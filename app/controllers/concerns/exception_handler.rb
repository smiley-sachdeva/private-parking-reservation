module ExceptionHandler
    extend ActiveSupport::Concern

    included do
        rescue_from StandardError, with: :handle_exception
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found       

        private

        def record_not_found(exception)
            model_name = exception.model.constantize.model_name.human
            render json: { error: "#{model_name} not found" }, status: :not_found
        end

        def handle_exception(exception)
            # Log the exception
            Rails.logger.error "An error occurred: #{exception.message}"

            # Render an error response
            render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
        end
    end

end