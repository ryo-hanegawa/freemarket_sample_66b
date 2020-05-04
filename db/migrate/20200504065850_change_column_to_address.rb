class ChangeColumnToAddress < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :addresses, :users
  end
end
