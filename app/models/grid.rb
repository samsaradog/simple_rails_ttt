require "constants"

CENTER_POSITION = 8
OUTSIDE_SIZE    = 8

class Grid
  attr_reader :state, :x_moves, :o_moves, :available_moves
  
  def initialize
    @state = :open
    @x_moves = []
    @o_moves = []
    @available_moves = (0..8).to_a
  end
  
  def initialize_copy(other)
    raise RuntimeError unless Grid == other.class
    @state = other.state
    @x_moves = other.x_moves.dup
    @o_moves = other.o_moves.dup
    @available_moves = other.available_moves.dup
  end
  
  def add!(token,position)
    raise RangeError unless in_range?(position)
    raise RuntimeError unless ( 0 != available.count(position))
    raise RuntimeError unless ( ( X_TOKEN == token ) || ( O_TOKEN == token ) )
    
    @x_moves << position if X_TOKEN == token
    @o_moves << position if O_TOKEN == token
    @available_moves -= [position]
    
    @state = update_state
    self
  end
  
  def ==(other)
    ( x_moves.sort == other.x_moves.sort ) && 
    ( o_moves.sort == other.o_moves.sort ) &&
    ( available_moves.sort = other.available_moves.sort )
  end
  
  def in_range?(position)
    position.to_s =~ /[0-8]/
  end
  
  def grid_full?
    available_moves.empty?
  end
  
  def available
    available_moves.dup
  end
  
  def is_draw?
    :draw == state
  end
  
  def update_state
    return :x_win if has_winner?(X_TOKEN)
    return :o_win if has_winner?(O_TOKEN)
    return :draw  if grid_full?
    :open
  end
  
  def has_winner?(token)
    case token
      when X_TOKEN 
        game_winner?(x_moves) 
      when O_TOKEN 
        game_winner?(o_moves) 
      else 
        raise RuntimeError
    end
  end
  
  def game_winner?(moves)
    edge_winner?(moves - [CENTER_POSITION]) || cross_winner?(moves)
  end
  
  def edge_winner?(moves)
    moves.sort.each do |x|
      next if ( 0 != (x % 2))
      next unless moves.include?((x+1) % OUTSIDE_SIZE)
      next unless moves.include?((x+2) % OUTSIDE_SIZE)
      return true
    end
    false
  end
  
  def cross_winner?(moves)
    return false unless moves.include?(CENTER_POSITION)
    
    outside_moves = moves - [CENTER_POSITION]
    
    outside_moves.sort.each do |x|
      next unless outside_moves.include?((x+4) % OUTSIDE_SIZE)
      return true
    end
    
    false
  end
  
end