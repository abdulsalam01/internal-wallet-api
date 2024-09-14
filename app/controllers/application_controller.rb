class ApplicationController < BaseController
  def initialize
    @encryptor = Encryptor.new
  end

  private

  def authenticate_request
    authorization_header = request.headers["Authorization"]
    if authorization_header.blank?
      render json: { error: "Authorization header is missing" }, status: :unauthorized
    end

    @current_user = @encryptor.decrypt(authorization_header)
    if @current_user.blank?
      render json: { error: "Invalid authorization token" }, status: :unauthorized
    end

    @wallet = Wallet.find_by(id: @current_user)
    if @wallet.nil?
      render json: { error: "Wallet not found" }, status: :not_found
    end
  end

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
