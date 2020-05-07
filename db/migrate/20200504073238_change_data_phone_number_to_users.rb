class ChangeDataPhoneNumberToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :phone_number, :string
  end
end
