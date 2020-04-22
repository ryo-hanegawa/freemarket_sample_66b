class CreateAddresses < ActiveRecord::Migration[5.2]
  add_column :addresses, :first_name, :string, null: false, default: '', limit: 15
  add_column :addresses, :last_name, :string, null: false, default: '', limit: 15
  add_column :addresses, :first_name_reading, :string, null: false, default: '', limit: 15
  add_column :addresses, :last_name_reading, :string, null: false, default: '', limit: 15
  end