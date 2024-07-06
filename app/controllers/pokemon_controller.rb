class PokemonController < ApplicationController
  def index
    if params[:search]
      @pokemons = Pokemon.search(params[:search]).page(params[:page]).per(30)
    else
      @pokemons = Pokemon.page(params[:page]).per(30)
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end



  #TODO: limit parameters

end
