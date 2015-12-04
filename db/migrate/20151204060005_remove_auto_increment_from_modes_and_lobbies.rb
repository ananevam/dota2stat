class RemoveAutoIncrementFromModesAndLobbies < ActiveRecord::Migration
  def change
    change_column :modes, :id, :integer,:auto_increment => false
    change_column :lobbies, :id, :integer, :auto_increment => false
  end
end
