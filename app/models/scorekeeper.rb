class Scorekeeper
  
  def self.update_cards(state,cipher)
    return if :open == state
    
    other_cipher = Cipher.switch_cipher_player(cipher)
    
    [cipher,other_cipher].each do |c|
      current_match = Match.find_by_cipher(c)
      current_player = Player.find(current_match.player_id)
      current_player.scorecard.update_score(state,c)
      current_player.scorecard.save
    end
  end
  
end