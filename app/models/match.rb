# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  cipher     :integer
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :cipher
  belongs_to :player
  
  validates :player_id, presence: true
  validates :cipher, presence: true
  
  def open?
    current_record = GameState.find_by_cipher(cipher)
    :open == current_record.game.state
  end
  
  def role
    Cipher.decode_player(cipher)
  end
  
  def waiting_on
    current_record = GameState.find_by_cipher(cipher)
    current_record.player
  end
end
