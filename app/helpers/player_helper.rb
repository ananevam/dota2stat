module PlayerHelper
  def kda_format kda
    sprintf("%.2f", kda)
  end

  def kda kills, deaths, assists
    (kills + assists).to_f / (deaths > 0 ? deaths : 1)
  end
end
