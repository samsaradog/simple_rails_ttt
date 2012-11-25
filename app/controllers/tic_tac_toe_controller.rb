class TicTacToeController < ApplicationController
  
  def home
    current_game = Game.new(get_cookie_value)
    current_game.add_first_move
    set_cookie_value(current_game.memento)
    @notification = current_game.notification
    @condition    = current_game.condition
  end
  
  def move
    current_game = Game.new(get_cookie_value)
    current_game.add_human_move(params[:move])
    set_cookie_value(current_game.memento)
    redirect_to :root
  end
  
  def new_game # used for new game button
    current_game = Game.new
    set_cookie_value(current_game.memento)
    redirect_to :root
  end
  
  def set_cookie_value(cookie_value)
    cookies.signed[:game_state] = cookie_value
  end
  
  def get_cookie_value
    cookies.signed[:game_state]
  end
  
end
