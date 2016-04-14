class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items
  validates :user_id, presence: true


  def calculate_price_based_on_qty
    total = []
    self.cart_items.where(purchased: nil, receipt_id: nil).each do |cart_item|
      if cart_item.price == nil
        cart_item.price = 5
        cart_item.quantity = 1
        cart_item.save
      else
      end
      price_based_on_quantity = cart_item.price * cart_item.quantity
      total << price_based_on_quantity
    end
    total.sum
  end

  def prepare_receipt_details(amount, charge)
    confirmation_details = []
    confirmation_details << amount
    confirmation_details << charge[:amount]
    confirmation_details << charge[:source][:address_line1]
    confirmation_details << charge[:source][:address_line2]
    confirmation_details << charge[:source][:address_city]
    confirmation_details << charge[:source][:address_state]
    confirmation_details << charge[:source][:address_zip]
    confirmation_details << charge[:source][:address_country]
    confirmation_details << charge[:source][:last4]
    confirmation_details << charge[:source][:brand]
    return confirmation_details
  end




  def create_receipt(confirmation_details)
    receipt = Receipt.create!(
    cart_item_id: confirmation_details.first,
    price: confirmation_details[1],
    adr_1: confirmation_details[2],
    adr_2: confirmation_details[3],
    city: confirmation_details[4],
    state: confirmation_details[5],
    zip: confirmation_details[6],
    last_4: confirmation_details[8])
    return receipt
  end

  def mark_cart_items_purchased(receipt_id)
    self.cart_items.each do |cart_item|
      if cart_item.purchased == true
      elsif cart_item.price < 1 || cart_item.price == nil
      else
        cart_item.receipt_id = receipt_id
        cart_item.purchased = true
        cart_item.save!
      end
    end
  end








end
