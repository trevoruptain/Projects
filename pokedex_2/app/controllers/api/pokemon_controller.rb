class Api::PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.all
  end

  def show
    @poke = Pokemon.find(params[:id])
  end
end
