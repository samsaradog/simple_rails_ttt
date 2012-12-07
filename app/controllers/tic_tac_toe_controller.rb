class TicTacToeController < ApplicationController
  
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
  
  def initialize_game
    current_record = GameState.new
    current_record.initialize_player
    current_record.reset
    current_record.save
    
    redirect_to "/#{current_record.cipher(X_TOKEN)}"
  end
  
  def two_player_game
    record_id = GameState.decode_id(params[:cipher].to_i)
    current_record = GameState.find("#{record_id}")
    current_game = Game.new(current_record.token)
    
    @player         = GameState.decode_player(params[:cipher].to_i)
    @home_button    = X_TOKEN == @player
    @notification   = create_notification(current_game,current_record)
    @representation = current_game.representation
  end
  
  def fetch_record(cipher)
    GameState.find(GameState.decode_id(cipher.to_i))
  end
  
  def fetch_player(cipher)
    GameState.decode_player(cipher.to_i)
  end
  
  def reset_two_player_game
    current_record = fetch_record(params[:cipher])
    current_record.reset
    current_record.save
    create_player_return(Game.new(current_record.token),current_record)
  end
  
  def two_player_move
    current_player = fetch_player(params[:cipher])
    current_record = fetch_record(params[:cipher])
    current_game = Game.new(current_record.token)
    
    if ( current_player == current_record.player ) and
       ( current_game.can_still_make_moves? ) and
       ( current_game.available?(params[:move]))
       
        current_game.add_move(current_player,params[:move])
        current_record.token = current_game.memento
        current_record.switch_player!
        current_record.save
    end
    create_player_return(current_game,current_record)
  end
  
  def create_player_return(game,record)
    render json: { notification: create_notification(game,record),
                   representation: game.representation }.to_json
  end
    
  def create_notification(game,record)
    return game.notification unless game.can_still_make_moves?
    return "Waiting for X move" if "X" == record.player
    return "Waiting for O move" if "O" == record.player
  end
  
  def get_update
    current_record = fetch_record(params[:cipher])
    current_game = Game.new(current_record.token)
    create_player_return(current_game,current_record)
  end
  
  def invite
    new_cipher = GameState.switch_cipher_player(params[:cipher].to_i)
    Invite.tic_tac_toe(params[:user_email],
    "#{request.protocol}#{request.host_with_port}\/#{new_cipher}").deliver
    redirect_to :back
  end
end
