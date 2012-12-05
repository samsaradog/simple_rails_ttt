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
  
  def two_player_game
    current_record = GameState.first()
    
    unless current_record
      current_record = GameState.new()
      current_record.player = params[:player]
    end
    
    current_record.token = " " * 9
    current_record.save
    
    current_game = Game.new(current_record.token)
    @notification   = create_notification(current_game,current_record)
    @representation = current_game.representation
  end
  
  def new_two_player_game
    current_record = GameState.first()
    current_record.token = " " * 9
    current_record.player = switch_player(current_record.player)
    current_record.save
    create_player_return(Game.new(current_record.token),current_record)
  end
  
  def player_move
    current_record = GameState.first()
    current_game = Game.new(current_record.token)
    
    if ( params[:player] == current_record.player ) and
       ( current_game.can_still_make_moves? ) and
       ( current_game.available?(params[:move]))
       
        current_game.add_move(params[:player],params[:move])
        current_record.token = current_game.memento
        current_record.player = switch_player(params[:player])
        current_record.save
    end
    create_player_return(current_game,current_record)
  end
  
  def create_player_return(game,record)
    render json: { notification: create_notification(game,record),
                   representation: game.representation }.to_json
  end
  
  def switch_player(current_player)
    return "O" if ( "X" == current_player )
    "X"
  end
  
  def create_notification(game,record)
    return game.notification unless game.can_still_make_moves?
    return "Waiting for X move" if "X" == record.player
    return "Waiting for O move" if "O" == record.player
  end
  
  def get_update
    current_record = GameState.first()
    current_game = Game.new(current_record.token)
    create_player_return(current_game,current_record)
  end
  
  def invite
    Invite.tic_tac_toe(params[:address],
    "#{request.protocol}#{request.host_with_port}").deliver
    redirect_to :back
  end
end
