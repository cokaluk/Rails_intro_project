class PokemonController < ApplicationController
  def index
    @pokemons = Pokemon.page(params[:page]).per(30)
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end



  #TODO: limit parameters

end
