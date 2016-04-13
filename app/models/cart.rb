class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items
  validates :user_id, presence: true



  def combine_prices_and_ids
    cart_items = CartItem.where(cart_id: self.id)
    total_price = []
    cart_item_ids = []
    total_price_and_id = []

    cart_items.each do |cart_item|
      if cart_item.purchased == true
      elsif cart_item.purchased == nil || cart_item.price < 1
        cart_item.price = 5.00
        cart_item.save
      else
      end
      total_price << cart_item.price
      cart_item_ids << cart_item.id
    end
    total_price_and_id << total_price.sum
    total_price_and_id << cart_item_ids
    return total_price_and_id
  end

  def create_receipt(confirmation_details)
    receipt = Receipt.create!(
    cart_item_id: confirmation_details[0],
    price: confirmation_details[1],
    adr_1: confirmation_details[2],
    adr_2: confirmation_details[3],
    city: confirmation_details[4],
    state: confirmation_details[5],
    zip: confirmation_details[6],
    name: confirmation_details[8])
    return receipt
  end










end
