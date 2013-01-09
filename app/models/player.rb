# == Schema Information
#
# Table name: players
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)
#  bio              :string(255)
#  password_digest  :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  remember_token   :string(255)
#  activation_state :string(255)
#  activation_token :string(255)
#

class Player < ActiveRecord::Base
  attr_accessible :bio, :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :matches
  
  before_save { |player| player.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  
  def mark_as_inactive
    self.activation_token = SecureRandom.urlsafe_base64
    self.activation_state = "inactive"
    self.save
  end
  
  def mark_as_active
    self.activation_state = "active"
    self.save
  end
  
  def activated?
    "active" == self.activation_state
  end
  
  def create_match_if_needed(cipher)
    self.matches.create(cipher: cipher) if 
                  self.matches.where("cipher = ?", cipher).empty?
  end
  
  def open_matches
    self.matches.keep_if {|m| m.open? }
  end
  
  private

     def create_remember_token
       self.remember_token = SecureRandom.urlsafe_base64
     end
end
