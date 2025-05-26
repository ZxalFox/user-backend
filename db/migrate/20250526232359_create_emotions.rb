class CreateEmotions < ActiveRecord::Migration[8.0]
  def change
    create_table :emotions do |t|
      t.string :title
      t.text :description
      t.integer :intensity

      t.timestamps
    end
  end
end
