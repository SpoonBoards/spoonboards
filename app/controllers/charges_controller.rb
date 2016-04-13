class ChargesController < ApplicationController

  def new
    @cart = Cart.where(user_id: session[:user_id]).first
    total = []
    @cart.cart_items.where(purchased: nil, receipt_id: nil).each do |cart_item|
      if cart_item.price == nil
        cart_item.price = 5
        cart_item.save
      else
      end
      total << cart_item.price
    end
    @amount = total.sum
  end

    # @amount = (@amount * 100)



  def create
    @cart = Cart.where(user_id: session[:user_id]).first
    # @total_and_id = @cart.combine_prices_and_ids
    total = []
    @cart.cart_items.where(purchased: nil, receipt_id: nil).each do |cart_item|
      if cart_item.price == nil
        cart_item.price = 5
        cart_item.save
      else
      end
      total << cart_item.price
    end

    @amount = total.sum


    # @amount = (@total_and_id[0] * 100)

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => charge_amount = (@amount * 100).to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :receipt_email => customer.email
    )


    # Amount in cents
    @confirmation_details = []
    @confirmation_details << @amount
    @confirmation_details << @charge[:amount]
    @confirmation_details << @charge[:source][:address_line1]
    @confirmation_details << @charge[:source][:address_line2]
    @confirmation_details << @charge[:source][:address_city]
    @confirmation_details << @charge[:source][:address_state]
    @confirmation_details << @charge[:source][:address_zip]
    @confirmation_details << @charge[:source][:address_country]
    @confirmation_details << @charge[:source][:last4]
    @confirmation_details << @charge[:source][:brand]

    @receipt = @cart.create_receipt(@confirmation_details)
    @cart.mark_cart_items_purchased(@receipt.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
