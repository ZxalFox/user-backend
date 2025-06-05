class RemoveUserIdFromDiaryEntries < ActiveRecord::Migration[7.0]
  def change
    remove_column :diary_entries, :user_id
  end
end
