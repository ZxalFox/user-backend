class EntriesController < ApplicationController
  def index
    render json: Entry.all
  end

  def show
    entry = Entry.find(params[:id])
    render json: entry
  end

  def create
    entry = Entry.new(entry_params)
    if entry.save
      render json: entry, status: :created
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    entry = Entry.find(params[:id])
    if entry.update(entry_params)
      render json: entry
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy
    render json: { message: "Entry deleted successfully" }
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content)
  end
end
