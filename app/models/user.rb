class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  CONVERT_STEAM_ID32_NUMBER = 76561197960265728

  devise :omniauthable, :rememberable, :trackable
  has_many :players, :foreign_key => :account_id, :primary_key => :account_id

  def self.connect_to_steam oauth_hash
    @user = User.find_or_create_by(:uid => oauth_hash["uid"], :provider => oauth_hash["provider"])

    user_info = oauth_hash["info"]

    @user.nickname = user_info["nickname"]
    @user.name = user_info["name"]
    @user.image_url = user_info["image"]
    @user.profile_url = user_info["urls"]["Profile"]

    # convert 64bit steam id to 32bit steam id
    @user.account_id = @user.uid.to_i - self::CONVERT_STEAM_ID32_NUMBER
    @user.save
    @user
  end

  def win_rate matches
    matches.where(
        "(players.player_slot >= #{Player::PLAYER_SLOT_SPLIT_ID} AND matches.win = 1) OR (players.player_slot < #{Player::PLAYER_SLOT_SPLIT_ID} AND matches.win = 0)"
    ).count.to_f / (matches.count.to_f / 100)
  end

  def win_matches
    self.all_matches.where(
        "(players.player_slot >= #{Player::PLAYER_SLOT_SPLIT_ID} AND matches.win = 1) OR (players.player_slot < #{Player::PLAYER_SLOT_SPLIT_ID} AND matches.win = 0)"
    )
  end

  def lose_matches
    self.all_matches.where(
        "(players.player_slot >= #{Player::PLAYER_SLOT_SPLIT_ID} AND matches.win = 0) OR (players.player_slot < #{Player::PLAYER_SLOT_SPLIT_ID} AND matches.win = 1)"
    )
  end

  def all_matches
    Match.joins(:players).where("players.account_id" => self.account_id)
  end

  def normal_mm_matches
    self.all_matches.where("matches.lobby_type NOT IN (?)", [Lobby::RANKED_ID])
  end

  def ranked_mm_matches
    self.all_matches.where("matches.lobby_type IN (?)", [Lobby::RANKED_ID])
  end

  def all_pick_matches
    self.all_matches.where("matches.game_mode" => Mode::ALL_PICK_ID)
  end

  def game_mode_other_matches
    self.all_matches.where("matches.game_mode NOT IN (?)", [Mode::ALL_PICK_ID])
  end

  def dire_matches
    self.all_matches.where("players.player_slot >= (?)", Player::PLAYER_SLOT_SPLIT_ID)
  end

  def radiant_matches
    self.all_matches.where("players.player_slot < (?)", Player::PLAYER_SLOT_SPLIT_ID)
  end

  def russia_matches
    self.all_matches.where("matches.cluster IN (?)", Region::RUSSIA_ID)
  end

  def region_other_matches
    self.all_matches.where("matches.cluster NOT IN (?)", Region::RUSSIA_ID)
  end

  def matches_by_hero hero
    Match.joins(:players).where("players.account_id" => self.account_id).where("players.hero_id" => hero.id)
  end
end
