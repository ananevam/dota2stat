class AbilityPlayer < ActiveRecord::Base
  self.table_name = "abilities_players"
  belongs_to :player
  belongs_to :ability
end
