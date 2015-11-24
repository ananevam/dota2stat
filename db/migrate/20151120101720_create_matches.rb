class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :win, :default => 0
      t.integer :duration, :default => 0
      t.timestamp :start_time, :null => true
      t.integer :match_seq_num, :null => true
      t.index :match_seq_num
      t.integer :tower_status_radiant, :null => true
      t.integer :tower_status_dire, :null => true
      t.integer :cluster, :null => true
      t.integer :first_blood_time, :null => true
      t.integer :lobby_type, :null => true
      t.index :lobby_type
      t.integer :human_players, :default => 0
      t.integer :leagueid, :null => true
      t.index :leagueid
      t.integer :positive_votes, :default => 0
      t.integer :negative_votes, :default => 0
      t.integer :game_mode, :null => true
      t.index :game_mode
      t.integer :engine, :null => true

      t.timestamps null: false
    end
  end
end
