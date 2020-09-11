class AddHostToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :host, null: false, foreign_key: { to_table: :users }
  end
end
