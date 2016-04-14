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

    # Insert API call here dawg
    @result = HTTParty.post("https://api-dev.sproutpatterns.com:9517/order/create"),
        :body => { :fabric_id => 'This is the fabric id',
                   :user_id => 'SpoonBoards user_id',
                   :design_id => '111111',
                   :app_id => 2,
                 }.to_json,

        :headers => {"X-Auth-Token" => "#{ENV["SPOON_KEY"]}"

    receipt_details = @cart.prepare_receipt_details(@amount, @charge)
    @receipt = @cart.create_receipt(receipt_details)
    @cart.mark_cart_items_purchased(@receipt.id)




  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
