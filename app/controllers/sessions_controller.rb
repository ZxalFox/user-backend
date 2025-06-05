require 'jwt'

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    
    if user && user.password.to_s == session_params[:password]
      token = JWT.encode({ user_id: user.id }, "secret_key", 'HS256') # Define algoritmo de criptografia
      render json: { token: token, user_id: user.id }
    else
      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
