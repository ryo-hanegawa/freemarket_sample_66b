class AddColumnToAddress < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :postal_code
      t.integer :prefecture
      t.string :city
      t.string :street
      t.string :building
      t.references :user, foreign_key: true
    end
  end
end