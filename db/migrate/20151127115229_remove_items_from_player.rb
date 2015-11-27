class RemoveItemsFromPlayer < ActiveRecord::Migration
  def change
    remove_column :players, :item_0_id, :integer
    remove_column :players, :item_1_id, :integer
    remove_column :players, :item_2_id, :integer
    remove_column :players, :item_3_id, :integer
    remove_column :players, :item_4_id, :integer
    remove_column :players, :item_5_id, :integer
  end
end
