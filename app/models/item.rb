class Item < ActiveRecord::Base
  def picture_url
    "http://cdn.dota2.com/apps/dota2/images/items/#{name.sub('item_','')}_lg.png"
  end
end
