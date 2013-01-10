# == Schema Information
#
# Table name: scorecards
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  games_won  :integer
#  games_lost :integer
#  draw_games :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'
require 'constants'

describe Scorecard do
  let(:player) { FactoryGirl.create(:player)}
  before do
    @scorecard = player.scorecard
  end
  
  subject { @scorecard }
  
  it { should respond_to(:games_won) }
  it { should respond_to(:games_lost) }
  it { should respond_to(:draw_games) }
  it { should respond_to(:player_id) }
  it { should respond_to(:player) }
  
  its(:player) { should == player }
  
  describe "when player_id is not present" do
    before { @scorecard.player_id = nil }
    it { should_not be_valid }
  end
  
  describe "access to attributes" do
    it "should not allow access to player_id" do
      expect do
        Scorecard.new(player_id: player.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end 
    
    it "should not allow writing games_won" do
      pending("understanding access to active record variables")
      expect do
        @scorecard.games_won = 99
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end   
  end
  
  describe "initial values" do
    it "should have games_won at 0" do
      @scorecard.games_won.should == 0
    end
    it "should have games_lost at 0" do
      @scorecard.games_lost.should == 0
    end
    it "should have draw_games at 0" do
      @scorecard.draw_games.should == 0
    end
  end
  
  describe "incrementing values" do
    before do
      @scorecard.update_score(:draw,X_FACTOR)
      @scorecard.update_score(:x_win,X_FACTOR)
      @scorecard.update_score(:x_win,O_FACTOR)
    end
    it "should properly increment games_won" do
      @scorecard.games_won.should == 1
    end
    it "should properly increment games_lost" do
      @scorecard.games_lost.should == 1
    end
    it "should properly increment draw_games" do
      @scorecard.draw_games.should == 1
    end
  end

end
