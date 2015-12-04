class AddTeamToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :team, :integer, :nullable => true, :default => nil, :after => :account_id
    add_index :players, :team
  end
end
