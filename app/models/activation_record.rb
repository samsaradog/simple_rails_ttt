# == Schema Information
#
# Table name: activation_records
#
#  id         :integer          not null, primary key
#  active     :boolean          default(FALSE)
#  token      :string(255)
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ActivationRecord < ActiveRecord::Base
  attr_accessible :active, :token
  belongs_to :player
  validates :player_id, presence: true
end
