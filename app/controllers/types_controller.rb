class TypesController < ApplicationController
  def index
    if params[:search]
      @types = Type.search(params[:search]).page(params[:page]).per(30)
    else
      @types = Type.page(params[:page]).per(30)
    end
  end

  def show
    @type = Type.find(params[:id])
  end
end
