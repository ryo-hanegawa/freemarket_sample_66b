class AddColumnToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :postal_code, :integer, null: false
    add_column :addresses, :street, :string, null: false
    add_column :addresses, :building, :string, null: false
    add_reference :addresses, :user, foreign_key: true
  end
end