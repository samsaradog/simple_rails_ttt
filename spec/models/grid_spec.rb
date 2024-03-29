require "spec_helper"

describe "Grid" do
  before(:each) do
    @grid = Grid.new
  end
  
  context "shows available moves" do
    
    it "shows available moves when empty" do
      @grid.available.should == (0..8).to_a
    end

    it "shows available moves after a center move" do
      @grid.add!(X_TOKEN,8)
      @grid.available.should == (0..7).to_a
    end

    it "shows available moves after an edge move" do
      @grid.add!(X_TOKEN,4)
      result = (0..8).to_a - [4]
      @grid.available.should == result
    end

  end
  
  context "catches errors" do
    
    it "throws a RangeError for a move out of range" do
      lambda { @grid.add!(X_TOKEN,99) }.should raise_error(RangeError)
    end

    it "throws a RuntimeError for making an unavailable move" do
      @grid.add!(X_TOKEN,5)
      lambda { @grid.add!(X_TOKEN,5) }.should raise_error(RuntimeError)
    end
  end
  
  context "recognizes configurations" do
    
    it "recognizes an edge winning configuration" do
      (0..2).each { |x| @grid.add!(X_TOKEN,x) }
      @grid.has_winner?(X_TOKEN).should == true
    end

    it "recognizes another edge winning configuration" do
      [0,6,7].each { |x| @grid.add!(X_TOKEN,x) }
      @grid.has_winner?(X_TOKEN).should == true
    end
    
    it "recognizes edge winning configuration when grid full" do
      [0,2,5,6,7].each { | move | @grid.add!(X_TOKEN,move)}
      [1,3,4,8].each { | move | @grid.add!(O_TOKEN,move)}
      @grid.has_winner?(X_TOKEN).should == true
    end

    it "recognizes a configuration that is not a win" do
      (1..3).each { |x| @grid.add!(X_TOKEN,x) }
      @grid.has_winner?(X_TOKEN).should_not == true
    end
    
    it "recognizes another configuration that is not a win" do
      [4,8].each { |x| @grid.add!(X_TOKEN,x) }
      @grid.has_winner?(X_TOKEN).should_not == true
    end

    it "recognizes a winning cross configuration" do
      [1,5,8].each { |x| @grid.add!(X_TOKEN,x) }
      @grid.has_winner?(X_TOKEN).should == true
    end

    it "recognizes a draw configuration" do
      [1,2,4,5,7].each { |move| @grid.add!(X_TOKEN,move) }
      [0,3,6,8].each   { |move| @grid.add!(O_TOKEN,move) }
      @grid.is_draw?.should == true
    end

    it "recognizes a configuration that is not a draw" do
      (0..2).each { |x| @grid.add!(X_TOKEN,x) }
      @grid.is_draw?.should_not == true
    end
    
  end
  
  it "duplicates correctly" do
    another_grid = @grid.dup
    another_grid.add!(X_TOKEN,0)
    @grid.should_not == another_grid
  end
end
