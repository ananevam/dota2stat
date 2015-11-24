class Hero < ActiveRecord::Base
  self.table_name = "heroes"

  def picture_url
    "http://cdn.dota2.com/apps/dota2/images/heroes/#{name.sub('npc_dota_hero_','')}_sb.png"
  end
end
