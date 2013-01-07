class PlayersController < ApplicationController
  
  def home
  end
  
  def signup
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    
    if @player.mark_as_inactive
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
  end
  
  def activate
    if (@player = Player.find_by_activation_token(params[:id]))
      @player.mark_as_active
      sign_in @player
      flash[:success] = "User was successfully activated"
    else
      flash[:error] = "Activation failed"
    end
    redirect_to root_path
  end
end
