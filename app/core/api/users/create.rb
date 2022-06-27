# frozen_string_literal: true

module Api
  module Users
    class Create
      def call(params)
        
        binding.pry
        
        p 'This is user create call!'
        user = Spree::User.new(
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        )


        # if user.save
        #   payload = { user_id: user.id }
        #   session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        #   tokens = session.login

        #   response.set_cookie(JWTSessions.access_cookie,
        #                       value: tokens[:access],
        #                       httponly: true,
        #                       secure: Rails.env.production?)
          
        #   render json: { csrf: tokens[:csrf] }
        # else
        #   render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
        # end
        Success(user)
      end
      
    end
  end
end
