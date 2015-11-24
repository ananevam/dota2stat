
class Player < ActiveRecord::Base
  include JsonPlayer

  belongs_to :match
  belongs_to :hero
  belongs_to :user, :foreign_key => :account_id, :primary_key => :account_id

  belongs_to :item_0, :foreign_key => :item_0_id, :class_name => "Item"
  belongs_to :item_1, :foreign_key => :item_1_id, :class_name => "Item"
  belongs_to :item_2, :foreign_key => :item_2_id, :class_name => "Item"
  belongs_to :item_3, :foreign_key => :item_3_id, :class_name => "Item"
  belongs_to :item_4, :foreign_key => :item_4_id, :class_name => "Item"
  belongs_to :item_5, :foreign_key => :item_5_id, :class_name => "Item"

  has_many :matches

  PLAYER_SLOT_SPLIT_ID = 128

  def items
    0.upto(5).map{|num| self.try("item_#{num}")}.compact
  end

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
