class AddNamesToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :first_name, :string, null: false
    add_column :addresses, :last_name, :string, null: false
    add_column :addresses, :first_name_reading, :string, null: false
    add_column :addresses, :last_name_reading, :string, null: false
  end
end
