class PlayersController < ApplicationController
  
  def home
  end
  
  def signup
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    
    if @player.save
      flash[:success] = "Welcome to the Game!"
      redirect_to @player
    else
      render 'signup'
    end
  end
  
  def show
    @player = Player.find(params[:id])
  end
end
