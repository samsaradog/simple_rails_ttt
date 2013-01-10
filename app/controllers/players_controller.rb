class PlayersController < ApplicationController
  
  def home
  end
  
  def signup
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    
    if @player.save_as_inactive
      Invite.activation_needed_email(@player,
              "#{request.protocol}#{request.host_with_port}").deliver
      flash[:success] = "Please check your email for confirmation instructions"
      redirect_to root_path
    else
      render 'signup'
    end
  end
  
  def show
    @player = Player.find(params[:id])
    @open_matches = @player.open_matches
  end
  
  def leaders
    @scorecards = Scorecard.order_cards
  end
  
  def activate
    if (@player = Player.find_by_activation_token(params[:id]))
      @player.mark_as_active
      flash[:success] = "#{@player.name} was successfully activated"
      redirect_to signin_path
    else
      flash[:error] = "Activation failed"
      redirect_to root_path
    end
  end
  
end
