# == Schema Information
#
# Table name: game_states
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  player     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "spec_helper"
require "constants"

describe "GameState" do
  before(:each) do
    @game_state = GameState.new()
    @game_state.initialize_player
    @game_state.reset
  end
  
  it "should have an empty board when created" do
    @game_state.token.should == INITIAL_MEMENTO
  end
  
  it "should have a player" do
    @game_state.player.should_not == nil
  end
  
  it "should switch the player" do
    @game_state.player = X_TOKEN
    @game_state.switch_player!.player.should == O_TOKEN
  end
  
  it "creates a cipher" do
    @game_state.id = record_number = 34
    @game_state.cipher(X_TOKEN).should == ( X_FACTOR * record_number )
  end
  
  it "resets the game" do
    @game_state.token = X_TOKEN * 9
    @game_state.reset.token.should == INITIAL_MEMENTO
  end
end
