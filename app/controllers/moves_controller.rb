class MovesController < ApplicationController
  def index
    @moves = Move.page(params[:page]).per(30)
  end

  def show
    @move = Move.find(params[:id])
  end
end
