# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
  
      if user && user.authenticate(params[:password])
        token = SecureRandom.hex(16)
        session = user.sessions.create(token: token)
        render json: { token: session.token }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
  