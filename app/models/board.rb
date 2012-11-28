require_relative "constants"
require_relative "grid"
require_relative "brain"


BOARD_TO_GRID = {  "0" => 0, "1" => 1, "2" => 2,
                   "3" => 7, "4" => 8, "5" => 3,
                   "6" => 6, "7" => 5, "8" => 4 }

GRID_TO_BOARD = BOARD_TO_GRID.invert

class Board
  attr_reader :memento
  
  def initialize
    @grid  = Grid.new
    @memento = INITIAL_MEMENTO.dup
  end
  
  def add!(token,position)
    grid_position = BOARD_TO_GRID[position]
    @grid.add!(token,grid_position)
    @memento[position.to_i] = token
  end
  
  def recreate_board(memento)
    (0..8).each do |position|
      add!(memento[position], position.to_s) if ( " " != memento[position])
    end
  end
  
  def state
    @grid.state
  end
  
  def generate_x_move
    GRID_TO_BOARD[Brain.x_move(@grid)]
  end
  
end