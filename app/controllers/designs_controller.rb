class DesignsController < ApplicationController
  def index
  end

  def show
  end



  def new
  end

  def create
    @design = Design.new(design_params)
      if @design.save
      else
        render boards_path
      end
    end

  def destroy
    @design = Design.find(params[:design_id])
    @design.destroy
    # respond_to do |format|
    #   format.html { redirect_to boards_path, notice: 'Design was successfully removed.' }
    # end
  end

private

  def design_params
    params.require(:design).permit(:board_id, :spoonflower_id)
  end


end
