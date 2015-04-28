# == Schema Information
#
# Table name: warCombatZoneSystems
#
#  solarSystemID :integer          not null, primary key
#  combatZoneID  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class WarCombatZoneSystem < ActiveRecord::Base
  self.table_name = "warCombatZoneSystems"
end
