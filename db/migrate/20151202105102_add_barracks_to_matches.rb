class AddBarracksToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :barracks_status_radiant, :integer, :nullable => false, :default => 0, :after => :tower_status_dire
    add_column :matches, :barracks_status_dire, :integer, :nullable => false, :default => 0, :after => :barracks_status_radiant
  end
end
