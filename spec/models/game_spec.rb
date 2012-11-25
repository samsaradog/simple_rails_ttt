require "spec_helper"
require "constants"

describe "Game with no initial state" do
  before { @game = Game.new }
  
  subject { @game }
  
  it { should respond_to(:memento)}
  it { should respond_to(:add_move)}
  it { should respond_to(:notification)}
  it { should respond_to(:condition)}
  
  context "when possibly adding the first computer move" do

    it "doesn't change when the human goes first" do
      @game.stub(:computer_first?).and_return(false)
      @game.add_first_move.memento.should == INITIAL_MEMENTO
    end
    
    it "changes when the computer goes first" do
      @game.stub(:computer_first?).and_return(true)
      @game.add_first_move.memento.should_not == INITIAL_MEMENTO
    end
  end
  
  context "when adding a human move" do
    
    it "should change the memento after adding a move" do
      @game.add_human_move("0")
      @game.memento.should_not == INITIAL_MEMENTO
    end
    
    it "should not allow user to pick where they have already moved" do
      @game.add_human_move("0")
      previous_memento = @game.memento.dup
      @game.add_human_move("0")
      @game.memento.should == previous_memento
    end
  end
end

describe "Game with initial state" do
  
  describe "when memento passed to constructor is nil" do
    it "should have a memento == INITIAL_MEMENTO" do
      Game.new(nil).memento.should == INITIAL_MEMENTO
    end
  end
  
  describe "when memento passed to constructor has a value" do
    it "should have a memento == the new value" do
      new_memento = 'X XO OX X'
      Game.new(new_memento).memento.should == new_memento
    end
  end
  
end