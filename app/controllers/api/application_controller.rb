# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include JWTSessions::RailsAuthorization
    include Dry::Monads[:result]
    # protect_from_forgery prepend: true
    # skip_before_action :verify_authenticity_token
    
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  
    private
  
    def current_user
      @current_user ||= User.find(payload['user_id'])
    end
    
  
    def not_authorized
      render json: { error: 'Not an authorized request' }, status: :unauthorized
    end
    
  end
end
