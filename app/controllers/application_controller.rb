# ./user-backend/app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      @decoded_token = JsonWebToken.verify(token)
      # Opcional: Encontre o usuário no seu banco de dados
      # @current_user = User.find_by(email: @decoded_token[0]['email'])
    rescue JWT::DecodeError, JWT::VerificationError => e
      render json: { errors: "Token inválido ou expirado: #{e.message}" }, status: :unauthorized
    rescue
      render json: { errors: 'Token não fornecido ou malformado.' }, status: :unauthorized
    end
  end
end