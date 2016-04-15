class ChargesController < ApplicationController

  def new
    @cart = Cart.where(user_id: session[:user_id]).first
    @amount = @cart.calculate_price_based_on_qty

  end

  def create
    @cart = Cart.where(user_id: session[:user_id]).first
    @amount = @cart.calculate_price_based_on_qty

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



    receipt_details = @cart.prepare_receipt_details(@amount, @charge)
    @receipt = @cart.create_receipt(receipt_details)
    @cart.mark_cart_items_purchased(@receipt.id)





  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
