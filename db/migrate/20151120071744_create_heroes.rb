class CreateHeroes < ActiveRecord::Migration
  def change
    create_table :heroes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
