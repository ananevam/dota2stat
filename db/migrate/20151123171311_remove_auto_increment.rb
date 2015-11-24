class RemoveAutoIncrement < ActiveRecord::Migration
  def change
    change_column :lobbies, :id, :integer
    change_column :modes, :id, :integer
  end
end
