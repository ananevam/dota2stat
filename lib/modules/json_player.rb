module JsonPlayer
  FIELDS = [
      :account_id, :player_slot, :hero_id, :kills, :deaths, :assists, :leaver_status, :gold,
      :last_hits, :denies, :gold_per_min, :xp_per_min, :gold_spent, :hero_damage,
      :tower_damage, :hero_healing, :level
  ]

  def Player.create_from_json json_player
    player = Player.new

    FIELDS.each do |field|
      player[field] = json_player[field]
    end

    player.item_0_id = json_player[:item_0]
    player.item_1_id = json_player[:item_1]
    player.item_2_id = json_player[:item_2]
    player.item_3_id = json_player[:item_3]
    player.item_4_id = json_player[:item_4]
    player.item_5_id = json_player[:item_5]

    player

  end
end