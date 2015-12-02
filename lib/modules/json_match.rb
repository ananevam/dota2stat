module JsonMatch
  FIELDS = [
      :duration, :match_seq_num, :tower_status_radiant, :tower_status_dire,
      :barracks_status_radiant, :barracks_status_dire,
      :cluster, :first_blood_time, :lobby_type, :human_players, :leagueid,
      :positive_votes, :negative_votes, :game_mode, :engine
  ]
  def Match.create_from_json json_match
    match = Match.new
    match.id = json_match[:match_id]

    match.start_time = Time.at(json_match[:start_time]).to_datetime
    match.win = json_match[:radiant_win] ? :radiant : :dire
    FIELDS.each do |field|
      match[field] = json_match[field]
    end

    match.save
    match.players.destroy_all

    json_match[:players].each do |json_player|
      match.players << Player.create_from_json(json_player)
    end
    match
  end
end