class CreateDiaryEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :diary_entries do |t|
      t.date :date
      t.string :emotion
      t.text :note

      t.timestamps
    end
  end
end
