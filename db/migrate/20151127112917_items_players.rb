class ItemsPlayers < ActiveRecord::Migration
  def change
    create_table :items_players do |t|
      t.integer :item_id
      t.index :item_id
      t.integer :player_id
      t.index :player_id
    end
  end
end
