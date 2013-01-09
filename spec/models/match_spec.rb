require 'spec_helper'

describe Match do
  let(:player) { FactoryGirl.create(:player)}
  before do
    @match = player.matches.build(cipher: 123456)
  end
  
  subject { @match }
  
  it { should respond_to(:cipher) }
  it { should respond_to(:player_id) }
  it { should respond_to(:player) }
  its(:player) { should == player }

  describe "when player id is not present" do
    before { @match.player_id = nil }
    it { should_not be_valid }
  end
  
  describe "when cipher is not present" do
    before { @match.cipher = nil }
    it { should_not be_valid }
  end
  
  describe "controlled access" do
    it "should not give access to player id" do
      expect do
        Match.new(player_id: player.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
