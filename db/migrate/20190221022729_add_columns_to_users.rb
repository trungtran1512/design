class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :location, :string
    add_column :users, :fullname, :string
  end
end
