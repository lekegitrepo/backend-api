class ApplicationController < ActionController::Base
  include JWTSessions::RailsAuthorization
  protect_from_forgery prepend: true
  skip_before_action :verify_authenticity_token
  
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end
  

  def not_authorized
    render json: { error: 'Not an authorized request' }, status: :unauthorized
  end
  
end
