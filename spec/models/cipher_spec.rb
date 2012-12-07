require "spec_helper"
require "constants"

describe "Cipher" do
  
  it "recognizes an X cipher" do
    Cipher.decode_player(X_FACTOR*23).should == X_TOKEN
  end
  
  it "recognizes an O cipher" do
    Cipher.decode_player(O_FACTOR*23).should == O_TOKEN
  end
  
  it "gets a record number from a cipher" do
    record_number = 34
    Cipher.decode_id(X_FACTOR*record_number).should == record_number
  end
  
  it "switches the cipher for a player" do
    record_number = 34
    x_cipher = X_FACTOR * record_number
    o_cipher = O_FACTOR * record_number
    Cipher.switch_cipher_player(x_cipher).should == o_cipher
  end
  
end