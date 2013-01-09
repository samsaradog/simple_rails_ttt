class SessionsController < ApplicationController

  def new
  end

  def create
    player = Player.find_by_email(params[:session][:email].downcase)
    
    if player && player.authenticate(params[:session][:password])
      if player.activated?
        sign_in player
        redirect_back_or root_path
      else
        flash[:error] = "#{player.name} not activated. Please check your email for activation instructions."
        redirect_to root_path
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end  
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
