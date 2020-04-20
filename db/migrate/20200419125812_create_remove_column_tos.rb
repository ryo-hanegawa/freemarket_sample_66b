class CreateRemoveColumnTos < ActiveRecord::Migration[5.2]
  def up
  add_column :users, :birthday, :date, null: false
end

def down
  remove_column :users, :birth_year, :integer, null: false
  remove_column :users, :birth_month, :integer, null: false
  remove_column :users, :birth_day, :integer, null: false
  remove_column :users, :telephone, :integer, null: false, unique: true
  end
end
