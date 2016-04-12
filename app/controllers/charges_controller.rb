class ChargesController < ApplicationController

  def new
    # @cart_stuff = params[:format]

        @cart = Cart.where(user_id: session[:user_id]).first

        @cart_items = CartItem.where(cart_id: @cart.id)
        @cart_item_ids = []
        @total_price = []
        @purchased = []
        @cart_items.each do |cart_item|
          if cart_item.purchased == true
          elsif cart_item.purchased == false
              cart_item.purchased = 0
              cart_item.save
              @total_price << cart_item.price unless cart_item.price == nil
              @cart_item_ids << cart_item.id
          end
        end




  end

  def create

    @cart = Cart.where(user_id: session[:user_id]).first








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

    # @confirmation_details = []
    # @confirmation_details << @charge[:source][:address_line1]
    # @confirmation_details << @charge[:source][:address_line2]
    # @confirmation_details << @charge[:source][:address_city]
    # @confirmation_details << @charge[:source][:address_state]
    # @confirmation_details << @charge[:source][:address_zip]
    # @confirmation_details << @charge[:source][:address_country]
    # @confirmation_details << @charge[:source][:last4]
    # @confirmation_details << @charge[:source][:brand]
    # @confirmation_details << @charge[:amount]
    #
    # @purchased_items = []
    # @purchased_items << @cart_items[]


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
