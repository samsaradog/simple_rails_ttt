class TicTacToeController < ApplicationController
  
  def home
    current_game = Game.new(get_cookie_value)
    @notification   = current_game.notification
    @representation = current_game.representation
  end
  
  def move
    current_game = Game.new(get_cookie_value)
    current_game.add_human_move(params[:move])
    set_cookie_value(current_game.memento)
    create_return(current_game)
    # redirect_to :root
  end
  
  def new_game # used for new game button
    current_game = Game.new
    current_game.add_first_move
    set_cookie_value(current_game.memento)
    create_return(current_game)
    # redirect_to :root
  end
  
  def set_cookie_value(cookie_value)
    cookies.signed[:game_state] = cookie_value
  end
  
  def get_cookie_value
    cookies.signed[:game_state]
  end
  
  def create_return(game)
    render json: { notification: game.notification,
                   representation: game.representation }.to_json
  end
  
end
