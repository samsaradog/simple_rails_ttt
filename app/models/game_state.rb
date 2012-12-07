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
  
  def cipher(player)
    return self.id * X_FACTOR if ( X_TOKEN == player )
    return self.id * O_FACTOR if ( O_TOKEN == player )
  end
end
