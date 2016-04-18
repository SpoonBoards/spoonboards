class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    # @carts = Cart.all
    # @cart = Cart.where(user_id: session[:user_id]).first
    @cart = Cart.where(user_id: session[:user_id]).first

      @amount = @cart.calculate_price_based_on_qty

      @fabric_type_options = [['Basic Cotton Ultra ($17.50/yd)', 30], ['Satin ($18/yd)', 40], ['Kona® Cotton ($19/yd)', 44],
      ['Performance Piqué ($20/yd)', 33], ['Cotton Poplin ($20/yd)', 59], ['Poly Crepe de Chine ($23/yd)', 39],
      ['Cotton Lawn Ultra ($24/yd)', 47], ['Silky Faille ($24/yd)', 23], ['Performance Knit ($24/yd)', 21], ['Modern Jersey ($26.50/yd)', 31],
      ['Cotton Spandex Jersey ($26.75/yd)', 55], ['Fleece ($27/yd)', 56], ['Minky ($27/yd)', 46],
      ['Linen-Cotton Canvas ($27/yd)', 52], ['Organic Cotton Knit ($27/yd)', 5], ['Organic Cotton Sateen ($27/yd)', 36],
      ['Sport Lycra ($32/yd)', 50], ['  Heavy Cotton Twill ($32/yd)', 7], ['  Eco Canvas ($32/yd)', 34],
      ['Faux Suede ($34/yd)', 32], ['Silk Crepe de Chine ($38/yd)', 10]]






    # @carts.cart_items.where(purchased: false, receipt_id: nil)

    # @cart_stuff = params[:format]
  end


  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart.destroy_cart_items

    # respond_to do |format|
    #     format.html { redirect_to @board, notice: 'User was successfully created.' }
        # format.js   {}
        # format.json { render json: @board, notice: 'User was successfully created.'}

    # end




    # @boards = Board.where(user_id: session[:user_id])
    # @carts = Cart.where(user_id: session[:user_id])
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      # params.fetch(:cart, {})
      params.require(:cart).permit(:user_id)
    end
end
