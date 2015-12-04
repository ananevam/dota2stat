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

    player.team = json_player[:player_slot] >= Player::PLAYER_SLOT_SPLIT_ID ? Player::TEAM_DIRE : Player::TEAM_RADIANT

    json_item_ids = 0.upto(5).map{|num| json_player["item_#{num}".to_sym]}
    player.items.delete_all
    json_item_ids.each do |item_id|
      if item = Item.find_by_id(item_id)
        player.items << item
      end
    end

    player.abilities.delete_all
    if defined?(json_player[:ability_upgrades])
      json_player[:ability_upgrades].each do |json_ability|
        player.ability_players << AbilityPlayer.new(
            :ability_id => json_ability[:ability],
            :time => json_ability[:time],
            :level => json_ability[:level]
        )
      end
    end
    player

  end
end