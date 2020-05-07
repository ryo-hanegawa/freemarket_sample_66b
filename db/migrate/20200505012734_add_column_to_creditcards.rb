class AddColumnToCreditcards < ActiveRecord::Migration[5.2]
  def change
    add_column :creditcards, :user_id, :integer, null: false
    add_column :creditcards, :customer_id, :string, null: false
    add_column :creditcards, :card_id, :string, null: false
  end
end
