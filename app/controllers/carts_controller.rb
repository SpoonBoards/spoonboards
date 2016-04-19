class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  before_action :check_user

  # GET /carts
  # GET /carts.json
  def index
    # @carts = Cart.all
    # @cart = Cart.where(user_id: session[:user_id]).first
    # byebug


    @cart = Cart.where(user_id: session[:user_id]).first



      @amount = @cart.calculate_price_based_on_qty

      @fabric_type_options = [['Basic Cotton Ultra', 30], ['Satin', 40], ['Kona® Cotton', 44],
      ['Performance Piqué', 33], ['Cotton Poplin', 59], ['Poly Crepe de Chine', 39],
      ['Cotton Lawn Ultra', 47], ['Silky Faille', 23], ['Performance Knit', 21], ['Modern Jersey', 31],
      ['Cotton Spandex Jersey', 55], ['Fleece', 56], ['Minky', 46],
      ['Linen-Cotton Canvas', 52], ['Organic Cotton Knit', 5], ['Organic Cotton Sateen', 36],
      ['Sport Lycra', 50], ['Heavy Cotton Twill', 7], ['Eco Canvas', 34],
      ['Faux Suede', 32], ['Silk Crepe de Chine', 10]]

  end


  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart.destroy_cart_items

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

    def check_user
      if session[:user_id] == nil
        redirect_to login_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      # params.fetch(:cart, {})
      params.require(:cart).permit(:user_id)
    end
end
