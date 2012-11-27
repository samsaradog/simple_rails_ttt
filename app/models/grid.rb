require "constants"

CENTER_POSITION = 8
OUTSIDE_SIZE    = 8

class Grid
  attr_reader :center, :outside, :state
  
  def initialize(new_state = :open)
    @state = new_state
    @outside = Z_TOKEN * 8
    @center  = Z_TOKEN
  end
  
  def add!(token,position)
    raise RangeError unless in_range?(position)
    raise RuntimeError unless ( 0 != available.count(position))
    
    if ( CENTER_POSITION == position )
      @center = token
    else
      @outside[position] = token
    end
    @state = update_state
    self
  end
  
  def center=(value)
    @center = value
  end
  
  def outside=(value)
    @outside = value
  end
  
  def dup
    return_value = Grid.new(state)
    return_value.center  = center
    return_value.outside = outside.dup
    return_value
  end
  
  def ==(other)
    ( center == other.center ) && ( outside == other.outside )
  end
  
  def in_range?(position)
    position.to_s =~ /[0-8]/
  end
  
  def grid_full?
    (center != Z_TOKEN) && (!outside.include?(Z_TOKEN))
  end
  
  def available
    find_moves(Z_TOKEN)
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
    game_winner?(find_moves(token))
  end
  
  def find_moves(token)
    return_value = []
    i = 0
    outside.chars do |c|
      return_value << i if ( token == c )
      i += 1
    end
    return_value << CENTER_POSITION if token == center
    return_value
  end
  
  def game_winner?(moves)
    edge_winner?(moves - [CENTER_POSITION]) || cross_winner?(moves)
  end
  
  def edge_winner?(moves)
    moves.each do |x|
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
    
    outside_moves.each do |x|
      next unless outside_moves.include?((x+4) % OUTSIDE_SIZE)
      return true
    end
    
    false
  end
  
end