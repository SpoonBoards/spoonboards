class ChargesController < ApplicationController

  def new
    @cart = Cart.where(user_id: session[:user_id]).first
    @total_and_id = @cart.combine_prices_and_ids
    @amount = (@total_and_id[0] * 100)


  end


  def create
    @cart = Cart.where(user_id: session[:user_id]).first
    @total_and_id = @cart.combine_prices_and_ids
    @amount = (@total_and_id[0] * 100)

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount.to_i,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )


    # Amount in cents
    @confirmation_details = []
    @confirmation_details << @total_and_id.second
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
