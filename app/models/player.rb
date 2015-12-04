
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
  TEAM_DIRE = "dire"
  TEAM_RADIANT = "radiant"
  enum team: [ TEAM_RADIANT, TEAM_DIRE]

  def kda
    (kills + assists).to_f / (deaths > 0 ? deaths : 1)
  end

  def gold_earned
    (gold_per_min.to_f / 60 * match.duration).to_i
  end

  def win?
    ((team == TEAM_DIRE and match.win == TEAM_DIRE) or
        (team == TEAM_RADIANT and match.win == TEAM_RADIANT)) ? true : false
  end
end
