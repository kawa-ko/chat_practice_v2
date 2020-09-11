class RemoveUserIdFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :user_id, :integer
  end
end
