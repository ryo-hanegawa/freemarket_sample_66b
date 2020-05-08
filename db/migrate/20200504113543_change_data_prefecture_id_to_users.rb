class ChangeDataPrefectureIdToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :addresses, :postal_code, :string, null: false
  end
end
