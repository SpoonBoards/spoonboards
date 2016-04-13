class AddColumnToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :receipt_id, :integer
    add_column :receipts, :last_4, :integer
  end
end
