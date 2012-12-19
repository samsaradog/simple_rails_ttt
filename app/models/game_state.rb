require "constants"

class GameState < ActiveRecord::Base
  attr_accessor :game, :cipher_player

  def self.create_game
    current_record = GameState.new
    current_record.initialize_player
    current_record.reset
    current_record.save
    current_record
  end

  def self.find_by_cipher(cipher)
    current_record = GameState.find(Cipher.decode_id(cipher))
    current_record.game = Game.new(current_record.token)
    current_record.cipher_player = Cipher.decode_player(cipher)
    current_record
  end
  
  def initialize_player
    self.player = ( ( 0 == rand(2) ) ? X_TOKEN : O_TOKEN )
  end
  
  def reset
    @game = Game.new(INITIAL_MEMENTO)
    self.token = @game.memento
    self
  end
  
  def switch_player!
    if ( O_TOKEN == self.player )
      self.player = X_TOKEN 
    else
      self.player = O_TOKEN
    end
    self
  end
  
  def cipher(player)
    return self.id * X_FACTOR if ( X_TOKEN == player )
    return self.id * O_FACTOR if ( O_TOKEN == player )
  end
  
  def move_if_possible!(move)
    if possible_to_move?(move)
      @game.add_move(@cipher_player,move)
      self.token = @game.memento
      self.switch_player!
      self.save
    end
  end
  
  private
  
  def possible_to_move?(move)
    ( @cipher_player == self.player ) and
    ( @game.can_still_make_moves? ) and
    ( @game.available?(move))
  end
  
  
end
