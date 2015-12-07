class Hero < ActiveRecord::Base
  self.table_name = "heroes"
  has_many :players

  def picture_url style="sb"
    "http://cdn.dota2.com/apps/dota2/images/heroes/#{name.sub('npc_dota_hero_','')}_#{style.to_s}.png"
  end

  def kda_by_user user
    kills = players.where(:account_id => user.account_id).sum(:kills)
    assists = players.where(:account_id => user.account_id).sum(:assists)
    deaths = players.where(:account_id => user.account_id).sum(:deaths)

    (kills + assists).to_f / (deaths > 0 ? deaths : 1)
  end
end
