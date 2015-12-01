class Ability < ActiveRecord::Base

  def picture_url
    name == 'stats' ? "http://cdn.dota2.com/apps/dota2/images/workshop/itembuilder/stats.png" :
        "http://cdn.dota2.com/apps/dota2/images/abilities/#{name}_md.png"
  end
end
