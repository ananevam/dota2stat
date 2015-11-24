class AddLastUpdatedMatchIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_updated_match_id, :integer, :nullable => true, :default => nil, :after => :account_id
  end
end
