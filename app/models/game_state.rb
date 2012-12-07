require "constants"

class GameState < ActiveRecord::Base
  attr_accessible :token, :player
  
  def initialize_player
    self.player = ( ( 0 == rand(2) ) ? X_TOKEN : O_TOKEN )
  end
  
  def reset
    self.token = INITIAL_MEMENTO
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
  
  def self.decode_player(cipher)
    return X_TOKEN if ( 0 == (cipher % X_FACTOR) )
    return O_TOKEN if ( 0 == (cipher % O_FACTOR) )
  end
  
  def self.decode_id(cipher)
    return (cipher / X_FACTOR) if ( 0 == (cipher % X_FACTOR))
    return (cipher / O_FACTOR) if ( 0 == (cipher % O_FACTOR))
  end
  
  def self.switch_cipher_player(cipher)
    player = decode_player(cipher)
    id = decode_id(cipher)
    return id * X_FACTOR if ( O_TOKEN == player )
    return id * O_FACTOR if ( X_TOKEN == player )
  end
  
  def cipher(player)
    return self.id * X_FACTOR if ( X_TOKEN == player )
    return self.id * O_FACTOR if ( O_TOKEN == player )
  end
end
