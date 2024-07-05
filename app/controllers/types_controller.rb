class TypesController < ApplicationController
  def index
    @types = Type.page(params[:page]).per(30)
  end

  def show
    @type = Type.find(params[:id])
  end
end
