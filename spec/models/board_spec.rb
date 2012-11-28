require "spec_helper"

describe "Board" do
  before(:each) do
    @board = Board.new
  end
  
  context "recognizing game state" do
    
    it "recognizes a draw game" do
      ["0","2","3","7"].each { |x| @board.add!(X_TOKEN,x)}
      ["1","4","5","6","8"].each { |x| @board.add!(O_TOKEN,x)}
      @board.state.should == :draw
    end
    
    it "recognizes a game is not a draw" do
      ["0","2","3","7"].each { |x| @board.add!(X_TOKEN,x)}
      ["1","4","5","6"].each { |x| @board.add!(O_TOKEN,x)}
      @board.state.should_not == :draw
    end
  end
  
  context "checks for bad moves" do
    
    it "throws a range error when move out of range" do
      ["Z","9","|","-"," "].each do |move|
        lambda { @board.add!(X_TOKEN,move)}.should raise_error(RangeError)
      end
    end
    
    it "throws a runtime error if the move is already taken" do
      @board.add!(X_TOKEN,"4")
      lambda { @board.add!(X_TOKEN,"4") }.should raise_error(RuntimeError)
    end
  end
  
  it "returns the move as a character" do
    @board.generate_x_move.should match(/[0-8]/)
  end
  
  context "generating the right memento" do
    def adjust_board_and_memento(board,memento,token,index)
      board.add!(token,index.to_s)
      memento[index] = token
    end
    
    it "shows the initial memento" do
      @board.memento.should == INITIAL_MEMENTO
    end
    
    it "shows the memento correctly after some moves" do
      test_memento = INITIAL_MEMENTO.dup
      [0,3].each { |x| adjust_board_and_memento(@board,test_memento,X_TOKEN,x) }
      [1,6].each { |x| adjust_board_and_memento(@board,test_memento,O_TOKEN,x) }
      @board.memento.should == test_memento
    end
    
    it "adds moves correctly from a given memento" do
      test_memento = "X  OX  OX"
      @board.recreate_board(test_memento)
      @board.memento.should == test_memento
    end
  end
end
