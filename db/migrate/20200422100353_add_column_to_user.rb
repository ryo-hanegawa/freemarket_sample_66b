class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false, default: '', limit: 15
    add_column :users, :first_name, :string, null: false, default: '', limit: 15
    add_column :users, :last_name, :string, null: false, default: '', limit: 15
    add_column :users, :first_name_reading, :string, null: false, default: '', limit: 15
    add_column :users, :last_name_reading, :string, null: false, default: '', limit: 15
    add_column :users, :birth_year, :integer, null: false
    add_column :users, :birth_month, :integer, null: false
    add_column :users, :birth_day, :integer, null: false
    add_column :users, :telephone, :integer, null: false, unique: true
  end
end
