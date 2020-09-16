class AddProfToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prof, :string
  end
end
