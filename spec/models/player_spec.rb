# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  bio             :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#

require 'spec_helper'

describe Player do
  before { @player = Player.new(name: "Bubba", email: "bubba@bubba.com",
                                bio: "born and raised a bubba",
                                password: "something",
                                password_confirmation: "something") }
  subject { @player }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:bio) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:matches) }
  
  it { should be_valid }
  
  describe "when name not present" do
    before { @player.name = ""}
    it { should_not be_valid}
  end
  
  describe "when name is too long" do
    before { @player.name = "x" * 100}
    it { should_not be_valid}
  end
  
  describe "when email not present" do
    before { @player.email = ""}
    it { should_not be_valid}
  end
  
  describe "when email is invalid" do
    it "should recognize a bad email address" do
      addresses = %w[boo@1,2 one.two who@where. one@two+three.com a@b_c.com]
      addresses.each do |bad_address|
        @player.email = bad_address
        @player.should_not be_valid
      end
    end
  end
  
  describe "when email is valid" do
    it "should recognize a bad email address" do
      addresses = %w[boo@bah.COM nobody@one.two.org 
                      who-what@where.com one+two@three.com a@bc.com]
      addresses.each do |good_address|
        @player.email = good_address
        @player.should be_valid
      end
    end
  end
  
  describe "when email already used" do
    before do
      another_player = @player.dup
      another_player.email = @player.email.upcase
      another_player.save
    end
    
    it { should_not be_valid }
  end
  
  describe "when password is not given" do
    before { @player.password = @player.password_confirmation = "" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation does not match" do
    before { @player.password_confirmation = "nothing" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @player.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "too short password" do
    before { @player.password = @player.password_confirmation = "x" * 7 }
    it { should be_invalid }
  end
  
  describe "authenticate method" do
    before { @player.save }
    let(:retrieved_player) { Player.find_by_email(@player.email) }
    
    describe "with good password" do
      it { should == retrieved_player.authenticate(@player.password)}
    end
    
    describe "with bad password" do
      let(:player_with_bad_password) { retrieved_player.authenticate("bogus") }
      it { should_not == player_with_bad_password }
      specify { player_with_bad_password.should be_false }
    end
    
  end
  
  describe "remember token" do
    before { @player.save }
    its(:remember_token) { should_not be_blank }
  end
end
