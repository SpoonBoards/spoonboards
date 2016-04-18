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
    @cart.cart_items.each do |f|
      @payload = {
           "ship_to": "SpoonBoards",
           "address1": "101 Curated Collections Way",
           "address2": "N/A",
           "city": "Durham",
           "state": "NC",
           "country": "US",
           "zipcode": "27713",
           "authorization_code": "pk_test_juhLZ4N1dtxNiZd1V680eCYy",
           "phone_number": "1-800-BRDS-R-GR8",
           "rush": 0,
           "freight_class_id": 2,
           "suppress_email": 0,
           "non_fabric": 0,
           "app_id": 2,
           "guest_checkout": 0,
           "user_id": 3541998,
           "paid_price": 5,
           "order_items": [
            {
              "quantity": f.quantity,
              "fabric_id": f.fabric_type,
              "design_id": f.spoonflower_id,
              "length_mm":203.2,
              "price": 5,
              "paid_price": 5,
              "app_id": 2
            }
          ]
        }

          pending_order = HTTParty.post('https://api-dev.sproutpatterns.com:9517/order/create/', :body => JSON.dump(@payload), :headers => {'X-Auth-Token' => "#{ENV["SPOON_KEY"]}", 'Content-Type' => 'application/json'})

          @all_order = []
          sf_order_id = pending_order["results"][0]["id"]
          processing_order = HTTParty.put("https://api-dev.sproutpatterns.com:9517/order/#{sf_order_id}/process", :headers => {'X-Auth-Token' => "#{ENV["SPOON_KEY"]}"})
          @all_order << sf_order_id
        end

    receipt_details = @cart.prepare_receipt_details(@amount, @charge)
    @receipt = @cart.create_receipt(receipt_details)
    @cart.mark_cart_items_purchased(@receipt.id)





  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
