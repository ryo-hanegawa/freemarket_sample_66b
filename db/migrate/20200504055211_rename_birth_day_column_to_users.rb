class RenameBirthDayColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :birth_day, :birth_date
    change_column :users, :birth_date, :string
  end
end
