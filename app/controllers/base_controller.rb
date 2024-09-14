class BaseController < ActionController::API
  rescue_from StandardError, with: :handle_internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::RoutingError, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_bad_request

  private
  # Helper logger
  def handle_internal_server_error(exception)
    log_error(exception) # You can log the error if needed
    render json: { error: "Something went wrong, please try again later." }, status: :internal_server_error
  end

  def handle_not_found(exception)
    render json: { error: "Resource not found." }, status: :not_found
  end

  def handle_bad_request(exception)
    render json: { error: "Bad request: #{exception.message}" }, status: :bad_request
  end

  def log_error(exception)
    Rails.logger.error(exception.message)
    Rails.logger.error(exception.backtrace.join("\n"))
  end
end
