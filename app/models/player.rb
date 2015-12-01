
class Player < ActiveRecord::Base
  include JsonPlayer

  belongs_to :match
  belongs_to :hero
  belongs_to :user, :foreign_key => :account_id, :primary_key => :account_id

  has_and_belongs_to_many :items
  has_and_belongs_to_many :abilities
  has_many :ability_players

  has_many :matches

  PLAYER_SLOT_SPLIT_ID = 128

  def kda
    (kills + assists).to_f / (deaths > 0 ? deaths : 1)
  end

  def gold_earned
    (gold_per_min.to_f / 60 * match.duration).to_i
  end

  def win?
    ((player_slot >= Player::PLAYER_SLOT_SPLIT_ID and match.win == "dire") or
        (player_slot < Player::PLAYER_SLOT_SPLIT_ID and match.win == "radiant")) ? true : false
  end
end
