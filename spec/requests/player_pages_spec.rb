require 'spec_helper'

describe "Player pages" do
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_content("Please Sign Up") }
    it { should have_selector('title', text: "TicTacToe") }
  end
  
  describe "home page" do
    before { visit root_path}
    
    it { should have_content('Welcome') }
    it { should have_content("Please Sign Up") }
  end
  
  describe "profile page" do
    let(:player) { FactoryGirl.create(:player) }
    before { visit player_path(player) }

    it { should have_selector('h1',    text: player.name) }
  end
  
  describe "signup" do

      before { visit signup_path }

      let(:submit) { "Join the Game" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(Player, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "Sweet and Evil"
          fill_in "Email",        with: "sweet@evil.com"
          fill_in "Bio",          with: "We are good boys"
          fill_in "Password",     with: "feedmenow"
          fill_in "Confirmation", with: "feedmenow"
        end

        it "should create a user" do
          expect { click_button submit }.to change(Player, :count).by(1)
        end
      end
    end
end
