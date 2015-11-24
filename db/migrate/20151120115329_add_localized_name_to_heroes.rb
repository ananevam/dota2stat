class AddLocalizedNameToHeroes < ActiveRecord::Migration
  def change
    add_column :heroes, :localized_name, :string, :after => :name
  end
end
