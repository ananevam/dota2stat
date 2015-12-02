
class Match < ActiveRecord::Base
  include JsonMatch

  enum win: [ :radiant, :dire]

  has_many :players, :dependent => :destroy
  belongs_to :lobby, :foreign_key => :lobby_type
  belongs_to :mode, :foreign_key => :game_mode
  belongs_to :region, :foreign_key => :cluster

  do_not_validate_attachment_file_type :map_picture

  has_attached_file :map_picture,
                    styles: {medium: "300x300>"},
                    default_url: "/images/:style/missing.png",
                    url: :set_map_picture_url

  def set_map_picture_url
    "/system/:attachment/#{self.start_time.strftime("%Y-%m")}/:id/map_:style.:extension"
  end

  def dire_players
    players.includes({:ability_players => :ability}, :hero, :items).select {|player| player.player_slot >= Player::PLAYER_SLOT_SPLIT_ID}
  end

  def radiant_players
    players.includes({:ability_players => :ability}, :hero, :items).select {|player| player.player_slot < Player::PLAYER_SLOT_SPLIT_ID}
  end

  def end_time
    start_time + duration.seconds
  end

  def player_by_user user
    players.detect{|p| p.account_id == user.account_id}
  end

  def generate_map
    Dota2api.map tower_status_radiant, tower_status_dire, barracks_status_radiant, barracks_status_dire
  end
  def generate_map!
    self.map_picture = File.open generate_map.path
    self.save
  end

end
