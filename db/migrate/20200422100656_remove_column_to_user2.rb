class RemoveColumnToUser2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :birth_year, :integer
    remove_column :users, :birth_month, :integer
    remove_column :users, :birth_day, :integer
    remove_column :users, :telephone, :integer
    end
end
