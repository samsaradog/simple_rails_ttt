require 'spec_helper'

describe "Home Page" do
  it "should have the content Can you beat" do
    visit '/'
    page.should have_content('Can you beat')
  end
end
