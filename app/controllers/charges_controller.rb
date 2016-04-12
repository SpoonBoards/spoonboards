class ChargesController < ApplicationController

  def new
    @cart_stuff = params[:format]
  end

  def create

    @cart = Cart.where(user_id: session[:user_id]).first
    @cart_items = CartItem.where(cart_id: @cart.id)

    # Amount in cents

    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @confirmation_details = []
    @confirmation_details << @charge[:source][:address_line1]
    @confirmation_details << @charge[:source][:address_line2]
    @confirmation_details << @charge[:source][:address_city]
    @confirmation_details << @charge[:source][:address_state]
    @confirmation_details << @charge[:source][:address_zip]
    @confirmation_details << @charge[:source][:address_country]
    @confirmation_details << @charge[:source][:last4]
    @confirmation_details << @charge[:source][:brand]
    @confirmation_details << @charge[:amount]




  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  # def confirmation_details
  #   confirmation_details = []
  #   @charge.each do |r|
  #     confirmation_details << r.
  #   end
end
