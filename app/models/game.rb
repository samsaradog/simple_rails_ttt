require "constants"

class Game
  attr_reader :memento
  
  def initialize(memento = INITIAL_MEMENTO)
    self.memento = memento
    set_up_board
  end
  
  def add_first_move
    if ( ( INITIAL_MEMENTO == memento ) and computer_first? )
      add_move(X_TOKEN,generate_x_move)
    end
  end
  
  def can_still_make_moves?
    return :open == state
  end
  
  def add_human_move(move)
    if available?(move)
      add_move(O_TOKEN,move)            if can_still_make_moves?
      add_move(X_TOKEN,generate_x_move) if can_still_make_moves?
    end
  end
  
  def available?(move)
    ! memento[move.to_i].presence
  end
  
  def add_move(token,move)
    @board.add!(token,move)
    self.memento = @board.memento
  end
  
  def notification
    STATE_TO_NOTIFICATION[state]
  end
  
  def representation
    return_value = {}
    (0..8).each { |n| return_value[n] = @memento[n] }
    return_value
  end
  
  def memento=(memento)
    @memento = memento.try(:dup) || INITIAL_MEMENTO
  end
  
  def set_up_board
    @board = Board.new
    @board.recreate_board(memento)
  end
  
  def generate_x_move
    @board.generate_x_move
  end
  
  def state
    @board.state
  end
  
  def computer_first?
    return ( 0 == rand(2) )
  end
end