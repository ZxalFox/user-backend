class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: { message: "Usuário criado com sucesso!", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
