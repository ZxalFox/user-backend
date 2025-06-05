class EmotionsController < ApplicationController
  def index
    render json: Emotion.all
  end

  def show
    emotion = Emotion.find(params[:id])
    render json: emotion
  end

  def create
    emotion = Emotion.new(emotion_params)
    if emotion.save
      ActionCable.server.broadcast("notifications", { type: "notification", text: "Nova emoção registrada!" })
      render json: emotion, status: :created
    else
      render json: { errors: emotion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    emotion = Emotion.find(params[:id])
    if emotion.update(emotion_params)
      render json: emotion
    else
      render json: { errors: emotion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    emotion = Emotion.find(params[:id])
    emotion.destroy
    render json: { message: "Emotion deleted successfully" }
  end

  private

  def emotion_params
    params.permit(:title, :description, :intensity)
  end
end
