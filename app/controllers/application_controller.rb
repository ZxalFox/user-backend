class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      @decoded_token = JsonWebToken.verify(token)
      
      # Provisionamento Just-in-Time:
      # Busca o usuário pelo ID único do Keycloak ('sub' no token).
      # Se não encontrar, cria um novo usuário no banco do Rails.
      @current_user = User.find_or_create_by!(uid: @decoded_token[0]['sub']) do |user|
        user.email = @decoded_token[0]['email']
        user.password = Devise.friendly_token[0, 20] # Senha aleatória, não será usada para login
        user.name = @decoded_token[0]['name']
        user.provider = 'keycloak'
      end

    rescue JWT::DecodeError, JWT::VerificationError => e
      render json: { errors: "Token inválido: #{e.message}" }, status: :unauthorized
    rescue => e
      render json: { errors: "Erro de autenticação: #{e.message}" }, status: :unauthorized
    end
  end
end