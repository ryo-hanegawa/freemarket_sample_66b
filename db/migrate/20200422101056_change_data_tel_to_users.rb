class ChangeDataTelToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :tel, :string
  end
end
