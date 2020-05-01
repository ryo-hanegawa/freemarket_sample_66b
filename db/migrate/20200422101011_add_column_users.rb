class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tel, :integer, null: false
  end
end
