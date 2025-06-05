class DiaryEntriesController < ApplicationController

  def create
    entry = DiaryEntry.new(entry_params)
    if entry.save
      render json: entry, status: :created
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    entries = DiaryEntry.order(date: :desc) # Ordenar por data
    render json: entries
  end


  private

  def entry_params
    params.require(:diary_entry).permit(:date, :emotion, :note)
  end
end
