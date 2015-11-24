class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :cost, :default => 0
      t.boolean :secret_shop, :default => false
      t.boolean :side_shop, :default => false
      t.boolean :recipe, :default => false
      t.string :localized_name

      t.timestamps null: false
    end
  end
end
