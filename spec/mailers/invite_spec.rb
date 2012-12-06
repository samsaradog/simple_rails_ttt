require "spec_helper"

describe Invite do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  
  before(:each) do
    @message = Invite.tic_tac_toe("nobody@nowhere.com","http://sample.com")
  end
  
  it "should be delivered to the addressee" do
    @message.should deliver_to("nobody@nowhere.com")
  end
  
  it "should have the correct subject line" do
    @message.should have_subject(/Come play/)
  end
  
  it "should have the right return address" do
    @message.should be_delivered_from("tictactoe@8thlight.com")
  end
end
