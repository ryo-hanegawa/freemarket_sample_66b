class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user,      foreign_key:true
      t.string  :name,         null:false
      t.text    :description,  null:false
      t.text    :brand
      t.integer :size,         null:false, default:0
      t.integer :category,     null:false, foreign_key:true
      t.integer :condition,    null:false, default:0
      t.integer :postage,      null:false, default:0    
      t.integer :prefecture,   null:false, default:0
      t.integer :deliberydate, null:false, default:0        
      t.integer :price,        null:false
      t.integer :buyer,        foreign_key:true, default:0
      t.timestamps
    end
  end
end
