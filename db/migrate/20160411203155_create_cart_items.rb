class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.decimal :price
      t.integer :quantity
      t.string :design_name
      t.integer :design_id
      t.integer :spoonflower_id
      t.string :thumbnail_url
      t.string :fabric_type
      t.boolean :purchased

      t.timestamps null: false
    end
  end
end
