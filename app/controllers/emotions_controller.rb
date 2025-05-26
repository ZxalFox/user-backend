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
    params.require(:emotion).permit(:title, :description, :intensity)
  end
end
