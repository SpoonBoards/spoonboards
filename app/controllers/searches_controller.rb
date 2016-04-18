class SearchesController < ApplicationController

  def index
      search_term = params["term"]
      @feature_display = Search.new(search_term)
      @boards = Board.where(user_id: session[:user_id])
  end

  def results
  end


end
