class DiaryEntry < ApplicationRecord
  validates :date, presence: true
  validates :emotion, presence: true
  validates :note, presence: true
end
