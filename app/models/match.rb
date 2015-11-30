
class Match < ActiveRecord::Base
  include JsonMatch

  enum win: [ :radiant, :dire]

  has_many :players, :dependent => :destroy
  belongs_to :lobby, :foreign_key => :lobby_type
  belongs_to :mode, :foreign_key => :game_mode
  belongs_to :region, :foreign_key => :cluster

  def dire_players
    players.select {|player| player.player_slot >= Player::PLAYER_SLOT_SPLIT_ID}
  end

  def radiant_players
    players.select {|player| player.player_slot < Player::PLAYER_SLOT_SPLIT_ID}
  end

  def end_time
    start_time + duration.seconds
  end

  def player_by_user user
    players.detect{|p| p.account_id == user.account_id}
  end
end
