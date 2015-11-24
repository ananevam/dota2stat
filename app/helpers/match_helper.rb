module MatchHelper
  def players_kda players
    (players.sum(&:kills) + players.sum(&:assists)).to_f / (players.sum(&:deaths) > 0 ? players.sum(&:deaths) :1 )
  end

  def how_k num
    if num > 999
      sprintf("%.1f", (num.to_f / 1000)) + "K"
    else
      num
    end
  end

  def duration_format duration
    Time.at(duration).utc.strftime(duration < 3600 ? "%M:%S":"%H:%M:%S")
  end

  def win_rate_format rate
    sprintf("%.1f", rate) + '%'
  end
end
