class PurchasedAndReceiptId < ActiveRecord::Migration
  def change
    add_column :carts, :receipt_id, :integer
    add_column :carts, :purchased, :boolean
  end
end
