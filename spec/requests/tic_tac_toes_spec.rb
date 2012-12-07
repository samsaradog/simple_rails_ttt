require 'spec_helper'
require 'constants'

describe "Home Page" do
  it "should have the content Welcome" do
    visit '/'
    page.should have_content('Welcome')
  end
end

describe "vs. Computer Page" do
  
  before { visit '/computer_game'}
  
  it "should have the content Can you beat" do
    page.should have_content('Can you beat')
  end
  
  it "should have a link back to the home page" do
    page.should have_content('Home')
  end
end
