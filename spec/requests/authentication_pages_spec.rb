require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end
  
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information and not activated" do
      let(:player) { FactoryGirl.create(:player) }
      before do
        fill_in "Email",    with: player.email
        fill_in "Password", with: player.password
        click_button "Sign in"
      end

      it { should_not have_link('Profile', href: player_path(player)) }
      it { should_not have_link('Sign out', href: signout_path) }
      it { should have_link('Home', href: root_path) }
      
    end
    
    # TODO - Figure out how to change the state of the database from within
    # this test
    
    # describe "with valid information and activated" do
    #   let(:player) { FactoryGirl.create(:player, activation_state: "active") }
    #   before do
    #     fill_in "Email",    with: player.email
    #     fill_in "Password", with: player.password
    #     click_button "Sign in"
    #   end
    # 
    #   it { should have_link('Profile', href: player_path(player)) }
    #   it { should have_link('Sign out', href: signout_path) }
    #   it { should_not have_link('Sign in', href: signin_path) }
    #   
    #   describe "followed by signout" do
    #     before { click_link "Sign out" }
    #     it { should_not have_link('Sign out') }
    #   end
    # end
  end
end
