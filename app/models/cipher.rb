require "constants"

class Cipher
  
  def self.decode_player(cipher)
    return X_TOKEN if ( 0 == (cipher % X_FACTOR) )
    return O_TOKEN if ( 0 == (cipher % O_FACTOR) )
  end
  
  def self.decode_id(cipher)
    return (cipher / X_FACTOR) if ( 0 == (cipher % X_FACTOR))
    return (cipher / O_FACTOR) if ( 0 == (cipher % O_FACTOR))
  end
  
  def self.switch_cipher_player(cipher)
    player = decode_player(cipher)
    id = decode_id(cipher)
    return id * X_FACTOR if ( O_TOKEN == player )
    return id * O_FACTOR if ( X_TOKEN == player )
  end
  
end
