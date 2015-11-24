class AddSkillToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :skill, :integer, :after => :win, :default=>nil, :nullable=>true
  end
end
