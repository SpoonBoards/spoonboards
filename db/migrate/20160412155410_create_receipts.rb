class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.integer :cart_item_id
      t.string :city
      t.string :adr_1
      t.string :adr_2
      t.string :state
      t.integer :zip
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
