class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  def add_to_cart
    design = Design.find(params[:design_id])
    @fabric_type = Board.find(params[:board_id]).fabric_type



    user_cart = User.find(session[:user_id]).carts.first.id
    api_response = []
    api_response << design.get_json_for_design(design.spoonflower_id, design.id)
    api_values = api_response.first
    api_values << user_cart
    cart_item = CartItem.new
    cart_item.create_cart_item_from_design(api_values, @fabric_type)
    redirect_to carts_path
  end

  def add_entire_board

    @board = Board.find(params[:board_id])
    @fabric_type = Board.find(params[:board_id]).fabric_type

    if @fabric_type == nil
    Board.find(params[:board_id]).fabric_type = 31
    @fabric_type = Board.find(params[:board_id]).fabric_type
    end

    user_cart = User.find(session[:user_id]).carts.first.id
    @board.designs.all.each do |design|
      api_response = []
      api_response << design.get_json_for_design(design.spoonflower_id, design.id)
      api_values = api_response.first
      api_values << user_cart
      cart_item = CartItem.new
      cart_item.create_cart_item_from_design(api_values, @fabric_type)
    end
    redirect_to carts_path
  end




  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart_item = CartItem.new(cart_item_params)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to carts_path, notice: 'Cart item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:cart_id, :price, :quantity, :design_name, :design_id, :spoonflower_id, :thumbnail_url, :fabric_type, :purchased)
    end
end
