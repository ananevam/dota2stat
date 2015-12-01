class AbilitiesPlayers < ActiveRecord::Migration
  def change
    create_table :abilities_players do |t|
      t.integer :ability_id
      t.index :ability_id
      t.integer :player_id
      t.index :player_id
      t.integer :time
      t.index :time
      t.integer :level
      t.index :level

      t.timestamps null: false
    end
  end
end
