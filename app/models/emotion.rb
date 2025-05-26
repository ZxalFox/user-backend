class Emotion < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :intensity, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
end
