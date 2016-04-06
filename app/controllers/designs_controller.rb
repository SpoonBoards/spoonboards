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
        redirect_to boards_path
      else
        render boards_path
      end
  end

private

def design_params
  params.require(:design).permit(:board_id, :spoonflower_id)
end


end
