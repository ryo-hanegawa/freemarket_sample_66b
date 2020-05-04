class RemoveTelToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :tel, :string
  end
end
