class ChangeDataBirthDayToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :birth_day, from: 0, to: nil
    change_column :users, :birth_day, :text
  end
end
