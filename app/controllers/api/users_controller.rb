# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    schema(:create) do
      required(:email).value(:string)
      required(:password).value(:string)
      required(:password_confirmation).value(:string)
      optional(:username).value(:string)
    end
  
    def create
      case resolve('api.users.create').call(safe_params.to_h)
      in Success(user, tokens)
        render :create, locals: { user: user, tokens: tokens }
      in Failure(errors)
        render json: { error: errors.full_messages.join(' ') }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
  end
end
