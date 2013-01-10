class TicTacToeController < ApplicationController
  before_filter :signed_in_user, only: [:two_player_game, :two_player_move]
  # before_filter :correct_user,   only: [:two_player_game]
  
  def home
  end
  
  def computer_game
    current_game = Game.new(get_cookie_value)
    @notification   = current_game.notification
    @representation = current_game.representation
  end
  
  def human_move
    current_game = Game.new(get_cookie_value)
    current_game.add_human_move(params[:move])
    set_cookie_value(current_game.memento)
    create_return(current_game)
  end
  
  def new_computer_game
    current_game = Game.new
    current_game.add_first_move
    set_cookie_value(current_game.memento)
    create_return(current_game)
  end
  
  # Above is for the computer vs. human game
  # Below is for the two-human game
  
  def initialize_game
    current_record = GameState.create_game
    redirect_to "/#{current_record.cipher(X_TOKEN)}"
  end
  
  def two_player_game
    current_player.create_match_if_needed(params[:cipher])
    current_record = GameState.find_by_cipher(params[:cipher].to_i)
    
    @player         = Cipher.decode_player(params[:cipher].to_i)
    @home_button    = X_TOKEN == @player
    @notification   = create_notification(current_record)
    @representation = current_record.game.representation
  end
  
  def reset_two_player_game
    current_record = GameState.find_by_cipher(params[:cipher].to_i)
    current_record.reset
    current_record.save
    create_player_return(current_record)
  end
  
  def two_player_move
    cipher_int = params[:cipher].to_i
    current_record = GameState.find_by_cipher(cipher_int)
    current_record.move_if_possible!(params[:move],cipher_int)
    create_player_return(current_record)
  end
  
  def get_update
    current_record = GameState.find_by_cipher(params[:cipher].to_i)
    create_player_return(current_record)
  end
  
  def invite
    new_cipher = Cipher.switch_cipher_player(params[:cipher].to_i)
    Invite.tic_tac_toe(params[:user_email],
    "#{request.protocol}#{request.host_with_port}\/#{new_cipher}").deliver
    flash[:success] = "Invitation delivered"
    redirect_to :back
  end
  
  def invite_to_join
    Invite.join(params[:user_email],
    "#{request.protocol}#{request.host_with_port}\/signup").deliver
    flash[:success] = "Invitation delivered"
    redirect_to :back
  end
  
  private
  
  def set_cookie_value(cookie_value)
    cookies.signed[:game_state] = cookie_value
  end
  
  def get_cookie_value
    cookies.signed[:game_state]
  end
  
  def create_return(game)
    render json: { notification:   game.notification,
                   representation: game.representation }.to_json
  end
    
  def create_player_return(record)
    render json: { notification: create_notification(record),
                   representation: record.game.representation }.to_json
  end
  
  def create_notification(record)
    return record.game.notification unless record.game.can_still_make_moves?
    return "Waiting for X move" if "X" == record.player
    return "Waiting for O move" if "O" == record.player
  end
    
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @player = Player.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
