class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|

      t.string :account_id, :null => true
      t.index :account_id
      t.integer :player_slot, :null => true
      t.integer :hero_id, :null => true
      t.index :hero_id
      t.integer :item_0_id, :null => true
      t.integer :item_1_id, :null => true
      t.integer :item_2_id, :null => true
      t.integer :item_3_id, :null => true
      t.integer :item_4_id, :null => true
      t.integer :item_5_id, :null => true
      t.integer :kills, :default => 0
      t.integer :deaths, :default => 0
      t.integer :assists, :default => 0
      t.integer :leaver_status, :null => true
      t.integer :gold, :default => 0
      t.integer :last_hits, :default => 0
      t.integer :denies, :default => 0
      t.integer :gold_per_min, :default => 0
      t.integer :xp_per_min, :default => 0
      t.integer :gold_spent, :default => 0
      t.integer :hero_damage, :default => 0
      t.integer :tower_damage, :default => 0
      t.integer :hero_healing, :default => 0
      t.integer :level, :default => 0

      t.references :match

      t.timestamps null: false
    end
  end
end
