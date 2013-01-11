# == Schema Information
#
# Table name: scorecards
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  games_won  :integer
#  games_lost :integer
#  draw_games :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Scorecard < ActiveRecord::Base
  # attr_accessible
  attr_accessible :draw_games, :games_lost, :games_won
  belongs_to :player
  validates :player_id, presence: true
  after_initialize :zero_out
  
  def zero_out
    unless persisted?
      self.draw_games ||= 0
      self.games_lost ||= 0
      self.games_won  ||= 0
    end
  end
  
  def update_score(state,cipher)
    role = Cipher.decode_player(cipher)
    if ( X_TOKEN == role )
      increment_as_x(state)
    elsif ( O_TOKEN == role )
      increment_as_o(state)
    end
  end
  
  def name
    Player.find(self.player_id).name
  end
  
  def total_games
    self.games_won + self.games_lost + self.draw_games
  end
  
  def pct_won
    return 0.0 unless (self.total_games > 0)
    
    (100.0 * self.games_won) / self.total_games
  end
  
  def self.order_cards
    Scorecard.all.sort { |a,b| b.pct_won <=> a.pct_won }
  end

private

    def increment_as_x(state)
      case state
      when :x_win 
        increment_games_won
      when :o_win 
        increment_games_lost
      when :draw  
        increment_draw_games
      end
    end
    
    def increment_as_o(state)
      case state
      when :x_win 
        increment_games_lost
      when :o_win 
        increment_games_won
      when :draw  
        increment_draw_games
      end
    end

    def increment_games_won
      self.games_won += 1
    end

    def increment_games_lost
      self.games_lost += 1
    end

    def increment_draw_games
      self.draw_games += 1
    end
end
