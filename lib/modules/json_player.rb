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

    json_item_ids = 0.upto(5).map{|num| json_player["item_#{num}".to_sym]}
    player.items.delete_all
    json_item_ids.each do |item_id|
      if item = Item.find_by_id(item_id)
        player.items << item
      end
    end
    player

  end
end