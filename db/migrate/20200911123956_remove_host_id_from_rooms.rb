class RemoveHostIdFromRooms < ActiveRecord::Migration[6.0]
  def change
    remove_column :rooms, :host_id
  end
end
