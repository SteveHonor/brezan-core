class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  rescue_from JWTSessions::Errors::ClaimsVerification, with: :forbidden

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def forbidden
    render json: { error: 'Forbidden' }, status: :forbidden
  end
end
