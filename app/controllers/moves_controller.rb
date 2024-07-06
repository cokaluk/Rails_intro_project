class MovesController < ApplicationController
  def index
    if params[:search]
      @moves = Move.search(params[:search]).page(params[:page]).per(30)
    else
      @moves = Move.page(params[:page]).per(30)
    end
  end

  def show
    @move = Move.find(params[:id])
  end
end
