class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :set_fabric_type, only: [:show]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.where(user_id: session[:user_id])
  end

  # GET /boards/1
  # GET /boards/1.json
  def show

    if @board.marked_private == true && @board.user_id != session[:user_id]
      redirect_to boards_path, notice: "You must be the Owner of this board to view"

    elsif @board.marked_private == true && @board.user_id == session[:used_id]

    elsif @board.marked_private == false && @board.user_id != session[:used_id]

    elsif @board.marked_private == false && @board.user_id == session[:used_id]

    else
    end

    @designs = @board.designs
    @feature_display = []
    @designs.each do |design|
      @feature_display <<  design.get_json_for_design(design.spoonflower_id, design.id)
    end
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  def clone_board
    @board = Board.find(params[:board_id])
    created_board = Board.create!(
    name: @board.name,
    user_id: session[:user_id],
    marked_private: @board.marked_private)

    @board.designs.all.each do |design|
    created_design = Design.create!(
    board_id: created_board.id,
    spoonflower_id: design.spoonflower_id)
    end

    redirect_to boards_path

  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'User was successfully created.' }
        format.js   {}
        format.json { render json: @board, notice: 'User was successfully created.'}
      else
        format.html { render action: "new" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fabric_type
      @fabric_type = [['Basic Cotton Ultra ($17.50/yd)', 30], ['Satin ($18/yd)', 40], ['Kona® Cotton ($19/yd)', 44],
      ['Performance Piqué ($20/yd)', 33], ['Cotton Poplin ($20/yd)', 59], ['Poly Crepe de Chine ($23/yd)', 39],
      ['Cotton Lawn Ultra ($24/yd)', 47], ['Silky Faille ($24/yd)', 23], ['Performance Knit ($24/yd)', 21], ['Modern Jersey ($26.50/yd)', 31],
      ['Cotton Spandex Jersey ($26.75/yd)', 55], ['Fleece ($27/yd)', 56], ['Minky ($27/yd)', 46],
      ['Linen-Cotton Canvas ($27/yd)', 52], ['Organic Cotton Knit ($27/yd)', 5], ['Organic Cotton Sateen ($27/yd)', 36],
      ['Sport Lycra ($32/yd)', 50], ['  Heavy Cotton Twill ($32/yd)', 7], ['  Eco Canvas ($32/yd)', 34],
      ['Faux Suede ($34/yd)', 32], ['Silk Crepe de Chine ($38/yd)', 10]]
    end

    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :user_id, :marked_private, :fabric_type)
    end
end
